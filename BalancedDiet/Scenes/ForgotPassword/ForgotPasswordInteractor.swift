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
    
    // MARK: - Initialization
    init(presenter: ForgotPasswordPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - ForgotPasswordBusinessLogic
extension ForgotPasswordInteractor: ForgotPasswordBusinessLogic {
    func fetchInitialData(request: ForgotPassword.InitialData.Request) {
        let response = ForgotPassword.InitialData.Response()
        presenter.presetInititalData(response: response)
    }
}
