//
//  SceneDelegate.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 21.03.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}
