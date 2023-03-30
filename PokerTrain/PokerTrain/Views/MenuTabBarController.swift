//
//  MenuTabBarController.swift
//  BirthdayReminder
//
//

import UIKit

class MenuTabBarController: UITabBarController {
    var coordinator1: AppCoordinator?
    var coordinator2: AppCoordinator?
    var coordinator3: AppCoordinator?
    var coordinator4: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = generateMainNavController(imageName: "Spade")
        let nav1 = generateMainNavController(imageName: "Timer")
        let nav2 = generateMainNavController(imageName: "Gauge")
        let nav3 = generateMainNavController(imageName: "Nut")

        UITabBar.appearance().unselectedItemTintColor = UIColor.init(rgb: 0xffffff, a: 0.4)
        UITabBar.appearance().tintColor = UIColor.init(rgb: 0xffffff)
        UITabBar.appearance().backgroundColor = UIColor.tabBar
        self.tabBar.backgroundColor = UIColor.tabBar
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
              tabBarAppearance.backgroundColor = .red // set your desired color here

             self.tabBar.standardAppearance = tabBarAppearance
            
        } else {
            self.tabBar.barTintColor =  UIColor.init(rgb: 0x191335, a: 1)
        }
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Raleway-Bold", size: 10)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        viewControllers = [nav, nav1, nav2, nav3]
        let bgView = UIImageView(image: UIImage(named: "TabBar"))
        bgView.frame = CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: tabBar.bounds.height + 10)
        bgView.backgroundColor = UIColor.init(rgb: 0x1c182f, a: 1)
        self.tabBar.addSubview(bgView)
        self.tabBar.sendSubviewToBack(bgView)
        ChangeRadiusOfTabbar()
    }
    
    func ChangeRadiusOfTabbar(){
  
      self.tabBar.layer.cornerRadius = 23
      self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        tabBar.layer.shadowColor = UIColor.black.cgColor
       
        tabBar.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: -5, width: tabBar.bounds.width, height: -25)).cgPath
        tabBar.layer.shadowRadius = 23
        tabBar.layer.shadowOpacity = 0.5
        tabBar.isTranslucent = false
        tabBar.layer.masksToBounds = false
        
     }
    
    private func generateMainNavController(imageName: String) -> UINavigationController {
        
        let navController = UINavigationController()
        navController.navigationBar.isHidden = true
        switch imageName {
        case "Spade":
            coordinator1 = AppCoordinator(navigationController: navController)
            title = "Обучение"

            coordinator1?.toLearn()
        case "Timer":
            coordinator2 = AppCoordinator(navigationController: navController)
            coordinator2?.toTimer()
            title = "Таймер"
        case "Gauge":
            coordinator3 = AppCoordinator(navigationController: navController)
            coordinator3?.toChance()
            title = "Вероятность"
        default:
            coordinator4 = AppCoordinator(navigationController: navController)
            coordinator4?.toSettings()
            title = "Настройки"
        }
        navController.tabBarItem.title = title
        navController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Raleway-Semibold", size: 10)!], for: .normal)
        
        navController.tabBarItem.image = UIImage(named: imageName)
        
    
        return navController
    }
    
}
