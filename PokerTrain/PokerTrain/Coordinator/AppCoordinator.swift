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
        switch UserDefaultsManager.shared.checkResult(.onboarding) {
        case true:
          toMain()
        case false:
          let vc = Onboarding.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        }
        
    }
    
    func toMain() {
        let vc = MainViewController()
         vc.viewModel = MainViewModel()
         vc.coordinator = self
         navigationController.pushViewController(vc, animated: true)
    }
    
    func toBack() {
        self.navigationController.popViewController(animated: true)
    }
}

