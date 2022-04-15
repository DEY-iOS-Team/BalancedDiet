//
//  SignupInteractor.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

final class SignupInteractor {
    // MARK: - Properties
    private let presenter: SignupPresentationLogic

    // MARK: - Initialization
    init(presenter: SignupPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - SignUpBusinessLogic
extension SignupInteractor: SignupBusinessLogic {
    func fetchInitialData(request: Signup.InitialData.Request) {
        let response = Signup.InitialData.Response()
        presenter.presetInititalData(response: response)
    }
}
