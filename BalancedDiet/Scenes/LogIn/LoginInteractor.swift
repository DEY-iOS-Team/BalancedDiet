//
//  LogInInteractor.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

final class LoginInteractor {
    // MARK: - Properties
    private let presenter: LoginPresentationLogic
    
    // MARK: - Initialization
    init(presenter: LoginPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - LoginBusinessLogic
extension LoginInteractor: LoginBusinessLogic {
    func fetchInitialData(request: Login.InitialData.Request) {
        let response = Login.InitialData.Response()
        presenter.presetInititalData(response: response)
    }
}
