//
//  SignupPresenter.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

final class SignupPresenter {
    // MARK: - Properties
    weak var viewController: SignupDisplayLogic?
}

// MARK: - SignUpPresentationLogic
extension SignupPresenter: SignupPresentationLogic {
    func presetInititalData(response: Signup.InitialData.Response) {
        let viewModel = Signup.InitialData.ViewModel(
            sceneNameLabelText: R.string.signupLocalization.signup(),
            signUpButtonTitle: R.string.signupLocalization.signup(),
            haveAccountLabelText: R.string.signupLocalization.haveAccount(),
            routeToLoginButtonTitle: R.string.signupLocalization.login()
        )
        viewController?.displayInititalData(viewModel: viewModel)
    }
}
