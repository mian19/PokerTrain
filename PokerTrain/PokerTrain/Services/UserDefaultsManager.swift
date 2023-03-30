//
//  UserDefaultsManager.swift
//  TraidingSimulator
//
//

import Foundation

enum CheckType: String {
case onboarding, firstEntrance
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    func saveURL(strURL: String, key: String) {
        let defaults = UserDefaults.standard

        // Save a URL to UserDefaults
        if let  url = URL(string: strURL) {
            defaults.set(strURL, forKey: key)
        } else {
            defaults.set("https://google.com", forKey: key)
        }

      
        
    }
    
    func getURL(key: String) -> String {
        // Read the URL from UserDefaults
        return  UserDefaults.standard.string(forKey: key)!
    }
    
    func saveCheck(_ checkType: CheckType) {
        UserDefaults.standard.set(true, forKey: checkType.rawValue)
    }
    
    func checkResult(_ checkType: CheckType) -> Bool {
        guard let onb = UserDefaults.standard.value(forKey: checkType.rawValue) as? Bool else { return false }
        return onb
    }
    
    
    
//    func saveSettings(settings: Settings) {
//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(settings)
//            UserDefaults.standard.set(data, forKey: "settings")
//        } catch {
//            print(error)
//        }
//    }
//
//    func getSettings() -> Settings {
//        var settings = Settings()
//        guard let data = UserDefaults.standard.data(forKey: "settings") else {
//            return Settings()
//        }
//        do {
//            let decoder = JSONDecoder()
//            settings = try decoder.decode(Settings.self, from: data)
//        } catch {
//            print(error)
//        }
//        return settings
//    }
//
//    func saveResults(results: [Int]) {
//            UserDefaults.standard.set(results, forKey: "results")
//    }
//
//    func getResults() -> [Int] {
//        UserDefaults.standard.object(forKey: "results") as? [Int] ?? []
//    }
}
