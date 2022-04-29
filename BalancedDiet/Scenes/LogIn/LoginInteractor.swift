//
//  LogInInteractor.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

final class LoginInteractor {
    // MARK: - Private Properties
    private let presenter: LoginPresentationLogic
    private let validator: ValidatorProtocol
    private let authService = FirebaseAuthService.shared
    private let firestoreService = FirebaseFirestoreService.shared

    // MARK: - Initialization
    init(presenter: LoginPresentationLogic, validator: ValidatorProtocol) {
        self.presenter = presenter
        self.validator = validator
    }

    // MARK: - Private Methods
    private func presentFailure(error: Login.LoginValidation.ErrorType) {
        let authResult = Login.LoginValidation.AuthResult.failure(error: error)
        let response = Login.LoginValidation.Response(authResult: authResult)
        presenter.presentLoginResult(response: response)
    }

    private func validation(request: Login.LoginValidation.Request) -> [Login.LoginValidation.ValidationError] {
        var errorArray: [Login.LoginValidation.ValidationError] = []

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
        return errorArray
    }
}

// MARK: - LoginBusinessLogic
extension LoginInteractor: LoginBusinessLogic {
    func fetchInitialData(request: Login.InitialData.Request) {
        let response = Login.InitialData.Response()
        presenter.presetInititalData(response: response)
    }

    func login(request: Login.LoginValidation.Request) {
        let errors = validation(request: request)
        if errors.isEmpty {
            let model = FirebaseAuthDTO.SignIn(email: request.email, password: request.password)
            authService.login(with: model) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    print("success")
                case .failure(let error):
                    self.presentFailure(error: .firebaseAuthError(message: error.message))
                }
            }
        } else {
            presentFailure(error: .validationError(message: errors))
        }
    }
}
