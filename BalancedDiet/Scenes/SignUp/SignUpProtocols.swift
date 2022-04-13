//
//  SignupProtocols.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

protocol SignupDisplayLogic: AnyObject {
    func displayInititalData(viewModel: Signup.InitialData.ViewModel)
}

protocol SignupBusinessLogic: AnyObject {
    func fetchInitialData(request: Signup.InitialData.Request)
}

protocol SignupPresentationLogic: AnyObject {
    func presetInititalData(response: Signup.InitialData.Response)
}

protocol SignupRoutingLogic: AnyObject {
    func routeToLogin()
}
