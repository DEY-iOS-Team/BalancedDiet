//
//  ForgotPasswordProtocols.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ForgotPasswordDisplayLogic: AnyObject {
    func displayInititalData(viewModel: ForgotPassword.InitialData.ViewModel)
    func displayResetPasswordResult(viewModel: ForgotPassword.ResetPasswordData.ViewModel)
}

protocol ForgotPasswordBusinessLogic: AnyObject {
    func fetchInitialData(request: ForgotPassword.InitialData.Request)
    func resetPassword(request: ForgotPassword.ResetPasswordData.Request)
}

protocol ForgotPasswordPresentationLogic: AnyObject {
    func presetInititalData(response: ForgotPassword.InitialData.Response)
    func presentResetPasswordResult(response: ForgotPassword.ResetPasswordData.Response)
}

protocol ForgotPasswordRoutingLogic: AnyObject {
}
