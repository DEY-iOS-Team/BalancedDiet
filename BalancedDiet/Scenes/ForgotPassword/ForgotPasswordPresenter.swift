//
//  ForgotPasswordPresenter.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

final class ForgotPasswordPresenter {
    // MARK: - Properties
    weak var viewController: ForgotPasswordDisplayLogic?
}

// MARK: - ForgotPasswordPresentationLogic
extension ForgotPasswordPresenter: ForgotPasswordPresentationLogic {
    func presetInititalData(response: ForgotPassword.InitialData.Response) {
        let viewModel = ForgotPassword.InitialData.ViewModel(
            titleText: R.string.forgotPasswordLocalization.titleText(),
            loginLinkButtonTitle: R.string.forgotPasswordLocalization.sendLoginLink()
        )
        viewController?.displayInititalData(viewModel: viewModel)
    }
}
