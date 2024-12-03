//
//  AppDelegate.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 28/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkMonitor.shared.startMonitoring()
        
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true

        let newsListCoordinator = NewsListCoordinator(navigation: navigation)
        newsListCoordinator.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}
