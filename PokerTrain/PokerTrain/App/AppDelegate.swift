//
//  AppDelegate.swift
//  PokerTrain
//
//  Created by Kyzu on 25.03.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        switch UserDefaultsManager.shared.checkResult(.onboarding) {
        case true:
         let vc = MenuTabBarController()
            window?.rootViewController = vc
        case false:
       
            let navController = UINavigationController()
            coordinator = AppCoordinator(navigationController: navController)
            coordinator?.start()
            window?.rootViewController = navController
        }
        
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("BYBY")
    }

}

