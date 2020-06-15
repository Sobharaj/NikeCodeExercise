//
//  SceneDelegate.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/10/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let dependenciesAlbumList = AlbumListViewModel.Dependencies(albumService: AlbumService())
        let viewModel: AlbumListViewModel = AlbumListViewModel(dependencies: dependenciesAlbumList)
        let dependenciesAlbumListVC = AlbumListViewController.Dependencies(viewModel: viewModel)

        self.window?.rootViewController = UINavigationController(rootViewController: AlbumListViewController(dependencies: dependenciesAlbumListVC ))
        
        self.window?.makeKeyAndVisible()

    }

    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

