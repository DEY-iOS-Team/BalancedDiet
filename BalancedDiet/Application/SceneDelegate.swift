//
//  SceneDelegate.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 21.03.22.
//

import UIKit
import FacebookCore
import GoogleSignIn
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        //Google SignIn
        GIDSignIn.sharedInstance.handle(url)

        //Facebook SignIn
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
        
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(rootViewController: LoginAssembly.assembly())
        window?.rootViewController = navigationController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}
