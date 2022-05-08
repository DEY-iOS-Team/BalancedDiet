//
//  ForgotPasswordInteractor.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class ForgotPasswordInteractor {
    // MARK: - Properties
    private let presenter: ForgotPasswordPresentationLogic
    private let authService: FirebaseAuthService
    private let firestoreService: FirebaseFirestoreService

    // MARK: - Initialization
    init(
        presenter: ForgotPasswordPresentationLogic,
        authService: FirebaseAuthService = FirebaseAuthService.shared,
        firestoreService: FirebaseFirestoreService = FirebaseFirestoreService.shared
    ) {
        self.presenter = presenter
        self.authService = authService
        self.firestoreService = firestoreService
    }
}

// MARK: - ForgotPasswordBusinessLogic
extension ForgotPasswordInteractor: ForgotPasswordBusinessLogic {
    func fetchInitialData(request: ForgotPassword.InitialData.Request) {
        let response = ForgotPassword.InitialData.Response()
        presenter.presetInititalData(response: response)
    }

    func resetPassword(request: ForgotPassword.ResetPasswordData.Request) {
        let model = FirebaseAuthDTO.ResetPassword(email: request.email)
        authService.resetPassword(with: model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                let response = ForgotPassword.ResetPasswordData.Response(authResult: .failure(error: error.message))
                self.presenter.presentResetPasswordResult(response: response)
            }
        }
    }
}
