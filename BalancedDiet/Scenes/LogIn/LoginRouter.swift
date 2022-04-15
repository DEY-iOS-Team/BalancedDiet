//
//  LoginRouter.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

import UIKit

final class LoginRouter: LoginRoutingLogic {
    var navigationController: UINavigationController?
    
    // MARK: - Properties
    weak var viewController: UIViewController?
    
    // MARK: - LoginRoutingLogic
    func routeToSignUp() {
        let signUpViewController = SignupAssembly.assembly()
        viewController?.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
