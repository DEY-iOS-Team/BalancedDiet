//
//  LoginProtocols.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

protocol LoginDisplayLogic: AnyObject {
    func displayInititalData(viewModel: Login.InitialData.ViewModel)
    func displayLoginResult(viewModel: Login.LoginValidation.ViewModel)
}

protocol LoginBusinessLogic: AnyObject {
    func fetchInitialData(request: Login.InitialData.Request)
    func login(request: Login.LoginValidation.Request)
}

protocol LoginPresentationLogic: AnyObject {
    func presetInititalData(response: Login.InitialData.Response)
    func presentLoginResult(response: Login.LoginValidation.Response)
}

protocol LoginRoutingLogic: AnyObject {
    func routeToForgotPassword()
    func routeToSignUp()
}
