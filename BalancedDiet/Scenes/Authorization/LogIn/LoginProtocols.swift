//
//  LoginProtocols.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

protocol LoginDisplayLogic: AnyObject {
    func displayInitialData(viewModel: Login.InitialData.ViewModel)
    func displayLoginResult(viewModel: Login.LoginData.ViewModel)
    func loginWithSocialNetwork(viewModel: Login.LoginWithSocialNetwork.ViewModel)
}

protocol LoginBusinessLogic: AnyObject {
    func fetchInitialData(request: Login.InitialData.Request)
    func login(request: Login.LoginData.Request)
    func loginWithSocialNetwork(request: Login.LoginWithSocialNetwork.Request)
}

protocol LoginPresentationLogic: AnyObject {
    func presentInitialData(response: Login.InitialData.Response)
    func presentLoginResult(response: Login.LoginData.Response)
    func presentSocialNetworkResult(response: Login.LoginWithSocialNetwork.Response)
}

protocol LoginRoutingLogic: AnyObject {
    func routeToForgotPassword()
    func routeToSignUp()
}
