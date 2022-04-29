//
//  LogInPresenter.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

final class LoginPresenter {
    // MARK: - Properties
    weak var viewController: LoginDisplayLogic?
}

// MARK: - LoginPresentationLogic
extension LoginPresenter: LoginPresentationLogic {
    func presetInititalData(response: Login.InitialData.Response) {
        let viewModel = Login.InitialData.ViewModel(
            forgotpasswordButtonTitle: R.string.loginLocalization.forgotPassword(),
            titleText: R.string.loginLocalization.login(),
            loginButtonTitle: R.string.loginLocalization.login(),
            loginWithGoogleButtonTitle: R.string.loginLocalization.loginWithGoogle(),
            loginWithGoogleButtonImage: R.image.google(),
            loginWithFacebookButtonImage: R.image.facebook(),
            loginWithFacebookButtonTitle: R.string.loginLocalization.loginWithFacebook(),
            haveAccountLabelText: R.string.loginLocalization.doesentHaveAccount(),
            routeToSignUpButtonTitle: R.string.loginLocalization.signUp(),
            lineViewText: R.string.loginLocalization.or()
        )
        viewController?.displayInititalData(viewModel: viewModel)
    }

    func presentLoginResult(response: Login.LoginValidation.Response) {
        let viewModel = Login.LoginValidation.ViewModel(authResult: response.authResult)
        viewController?.displayLoginResult(viewModel: viewModel)
    }
}
