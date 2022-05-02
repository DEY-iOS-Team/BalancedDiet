//
//  SignUpAssembly.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

import UIKit

enum SignupAssembly {
    static func assembly() -> UIViewController {
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        let interactor = SignUpInteractor(presenter: presenter)
        let viewController = SignupViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
