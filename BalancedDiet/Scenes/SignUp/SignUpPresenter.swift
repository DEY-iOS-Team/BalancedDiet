//
//  SignUpPresenter.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

final class SignUpPresenter {
    // MARK: - Properties
    weak var viewController: SignUpDisplayLogic?
}

// MARK: - SignUpPresentationLogic
extension SignUpPresenter: SignUpPresentationLogic {
    func presetInititalData(response: SignUp.InitialData.Response) {
        let viewModel = SignUp.InitialData.ViewModel(
            titleText: R.string.signupLocalization.signup(),
            signUpButtonTitle: R.string.signupLocalization.signup(),
            haveAccountLabelText: R.string.signupLocalization.haveAccount(),
            routeToLoginButtonTitle: R.string.signupLocalization.login()
        )
        viewController?.displayInititalData(viewModel: viewModel)
    }

    func presentSignUpResult(response: SignUp.SignUpValidation.Response) {
        let viewModel = SignUp.SignUpValidation.ViewModel(authResult: response.authResult)
        viewController?.displaySignUpResult(viewModel: viewModel)
    }
}
