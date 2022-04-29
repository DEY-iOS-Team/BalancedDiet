//
//  SignUpInteractor.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

final class SignUpInteractor {
    // MARK: - Private Properties
    private let presenter: SignUpPresentationLogic
    private let validator: ValidatorProtocol
    private let authService = FirebaseAuthService.shared
    private let firestoreService = FirebaseFirestoreService.shared

    // MARK: -  Properties
    var errorArray: [SignUp.SignUpValidation.ValidationError] = []

    // MARK: - Initialization
    init(presenter: SignUpPresentationLogic, validator: ValidatorProtocol) {
        self.presenter = presenter
        self.validator = validator
    }

    // MARK: - Private Methods
    private func presentFailure(error: SignUp.SignUpValidation.ErrorType) {
        let authResult = SignUp.SignUpValidation.AuthResult.failure(error: error)
        let response = SignUp.SignUpValidation.Response(authResult: authResult)
        presenter.presentSignUpResult(response: response)
    }

    private func validation(request: SignUp.SignUpValidation.Request) -> [SignUp.SignUpValidation.ValidationError] {
        if request.userName.isReallyEmpty() {
            errorArray.append(.userName(error: .empty))
        }
        if !validator.validate(with: request.userName, type: .userName) {
            errorArray.append(.userName(error: .wrongFormat))
        }
        if request.email.isReallyEmpty() {
            errorArray.append(.email(error: .empty))
        }
        if !validator.validate(with: request.email, type: .email) {
            errorArray.append(.email(error: .wrongFormat))
        }
        if request.password.isReallyEmpty() {
            errorArray.append(.password(error: .empty))
        }
        if !validator.validate(with: request.password, type: .password) {
            errorArray.append(.password(error: .wrongFormat))
        }
        if request.confirmPassword.isReallyEmpty() {
            errorArray.append(.confirmPassword(error: .empty))
        }
        if !(request.confirmPassword == request.password) {
            errorArray.append(.confirmPassword(error: .wrongFormat))
        }
        return errorArray
    }

    private func saveUser(id: String, userModel: FirebaseFirestoreDTO.User) {
        firestoreService.saveData(endpoint: SignUpEndpoint.save(id: id), model: userModel) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let response = SignUp.SignUpValidation.Response(authResult: SignUp.SignUpValidation.AuthResult.success)
                self.presenter.presentSignUpResult(response: response)
            case .failure:
                self.presentFailure(error: .firebaseAuthError(message: FirebaseFirestoreError.defaultError.message))
            }
        }
    }
}

// MARK: - SignUpBusinessLogic
extension SignUpInteractor: SignUpBusinessLogic {
    func fetchInitialData(request: SignUp.InitialData.Request) {
        let response = SignUp.InitialData.Response()
        presenter.presetInititalData(response: response)
    }

    func signUp(request: SignUp.SignUpValidation.Request) {
        let request = SignUp.SignUpValidation.Request(
            userName: request.userName,
            email: request.email,
            password: request.password,
            confirmPassword: request.confirmPassword
        )
        let errors = validation(request: request)
        if errors.isEmpty {
            let model = FirebaseAuthDTO.CreateUser(email: request.email, password: request.password)
            authService.createUser(with: model) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let id):
                    self.saveUser(
                        id: id,
                        userModel: FirebaseFirestoreDTO.User(userName: request.userName, email: request.email)
                    )
                case .failure:
                    self.presentFailure(error: .firebaseAuthError(message: FirebaseAuthError.networkError.message))
                }
            }
        } else {
            presentFailure(error: .validationError(message: errors))
        }
    }
}
