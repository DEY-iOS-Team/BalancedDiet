//
//  SignUpProtocols.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

protocol SignUpDisplayLogic: AnyObject {
    func displayInititalData(viewModel: SignUp.InitialData.ViewModel)
    func displaySignUpResult(viewModel: SignUp.SignUpValidation.ViewModel)
}

protocol SignUpBusinessLogic: AnyObject {
    func fetchInitialData(request: SignUp.InitialData.Request)
    func signUp(request: SignUp.SignUpValidation.Request)
}

protocol SignUpPresentationLogic: AnyObject {
    func presetInititalData(response: SignUp.InitialData.Response)
    func presentSignUpResult(response: SignUp.SignUpValidation.Response)
}

protocol SignUpRoutingLogic: AnyObject {
    func routeToLogin()
}
