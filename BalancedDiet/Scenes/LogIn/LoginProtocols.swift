//
//  LoginProtocols.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

protocol LoginDisplayLogic: AnyObject {
    func displayInititalData(viewModel: Login.InitialData.ViewModel)
}

protocol LoginBusinessLogic: AnyObject {
    func fetchInitialData(request: Login.InitialData.Request)
}

protocol LoginPresentationLogic: AnyObject {
    func presetInititalData(response: Login.InitialData.Response)
}

protocol LoginRoutingLogic: AnyObject {
    func routeToSignUp()
}
