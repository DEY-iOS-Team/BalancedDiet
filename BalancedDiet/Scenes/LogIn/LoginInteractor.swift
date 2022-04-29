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
    private let authService: FirebaseAuthService
    private let firestoreService: FirebaseFirestoreService

    // MARK: - Initialization
    init(
        presenter: LoginPresentationLogic,
        validator: ValidatorProtocol = ValidatorManager(),
        authService: FirebaseAuthService = FirebaseAuthService.shared,
        firestoreService: FirebaseFirestoreService = FirebaseFirestoreService.shared
    ) {
        self.presenter = presenter
        self.validator = validator
        self.authService = authService
        self.firestoreService = firestoreService
    }

    // MARK: - Private Methods
    private func presentFailure(error: Login.LoginData.ErrorType) {
        let authResult = Login.LoginData.AuthResult.failure(error: error)
        let response = Login.LoginData.Response(authResult: authResult)
        presenter.presentLoginResult(response: response)
    }

    private func validation(request: Login.LoginData.Request) -> [Login.LoginData.ValidationError] {
        var errorArray: [Login.LoginData.ValidationError] = []

        if request.email.isReallyEmpty() {
            errorArray.append(.email)
        }
        if request.password.isReallyEmpty() {
            errorArray.append(.password)
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

    func login(request: Login.LoginData.Request) {
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
