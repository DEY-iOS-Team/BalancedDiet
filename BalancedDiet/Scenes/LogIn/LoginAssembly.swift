//
//  LoginAssembly.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

import UIKit

enum LoginAssembly {
    static func assembly() -> UIViewController {
        let presenter = LoginPresenter()
        let router = LoginRouter()
        let interactor = LoginInteractor(presenter: presenter)
        let viewController = LoginViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
