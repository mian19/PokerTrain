//
//  AppCoordinator.swift
//  ImageSearcher
//
//  Created by Kyzu on 28.11.22.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
          let vc = Onboarding.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
    }
    
    func toMain() {
     
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        // Set the new view controller as the root view controller
        window.rootViewController = MenuTabBarController()
    }
    
    func toLearn() {
        let vc = LearnViewController()
         vc.coordinator = self
         navigationController.pushViewController(vc, animated: true)
    }
    
    func toTimer() {
        let vc = TimerViewController()
         vc.coordinator = self
         navigationController.pushViewController(vc, animated: true)
    }
    
    func toChance() {
        let vc = ChanceViewController()
         vc.coordinator = self
         navigationController.pushViewController(vc, animated: true)
    }
    
    func toSettings() {
        let vc = SettingsViewController()
         vc.coordinator = self
         navigationController.pushViewController(vc, animated: true)
    }
    
    func toBack() {
        self.navigationController.popViewController(animated: true)
    }
}

