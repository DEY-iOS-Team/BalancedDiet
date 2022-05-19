//
//  ForgotPasswordAssembly.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ForgotPasswordAssembly {
    static func assembly() -> UIViewController {
        let presenter = ForgotPasswordPresenter()
        let router = ForgotPasswordRouter()
        let interactor = ForgotPasswordInteractor(presenter: presenter)
        let viewController = ForgotPasswordViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
