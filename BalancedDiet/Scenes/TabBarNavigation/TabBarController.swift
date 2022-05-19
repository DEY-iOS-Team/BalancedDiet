//
//  TabBarController.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 18.05.22.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: - Private Methods
    private func setupTabBar() {
        viewControllers = [
            generateNavigationController(
                viewController: UIViewController(),
                title: R.string.tabBarLocalization.home(),
                icon: UIImage(systemName: "house") ?? UIImage()
            ),
            generateNavigationController(
                viewController: UIViewController(),
                title: R.string.tabBarLocalization.search(),
                icon: UIImage(systemName: "magnifyingglass") ?? UIImage()
            ),
            generateNavigationController(
                viewController: UIViewController(),
                title: R.string.tabBarLocalization.liked(),
                icon: UIImage(systemName: "heart") ?? UIImage()
            ),
            generateNavigationController(
                viewController: UIViewController(),
                title: R.string.tabBarLocalization.profile(),
                icon: UIImage(systemName: "person") ?? UIImage()
            )
        ]
    }

    private func generateNavigationController(
        viewController: UIViewController,
        title: String,
        icon: UIImage
    ) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.title = title
        navigationVC.tabBarItem.image = icon
        return navigationVC
    }
}
