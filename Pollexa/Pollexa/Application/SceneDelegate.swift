//
//  SceneDelegate.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        self.window = window
        self.appCoordinator = appCoordinator

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        appCoordinator.start()
    }
}
