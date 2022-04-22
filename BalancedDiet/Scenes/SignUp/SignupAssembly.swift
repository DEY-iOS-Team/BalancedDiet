//
//  SignUpAssembly.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

import UIKit

enum SignupAssemblssssy {
    static func assembly() -> UIViewController {
        let presenter = SignupPresenter()
        let router = SignupRouter()
        let interactor = SignupInteractor(presenter: presenter)
        let viewController = SignupViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
