//
//  SignupRouter.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

import UIKit

final class SignupRouter: SignupRoutingLogic {
    var navigationController: UINavigationController?

    // MARK: - Properties
    weak var viewController: UIViewController?

    // MARK: - SignupRoutingLogic
    func routeToLogin() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
