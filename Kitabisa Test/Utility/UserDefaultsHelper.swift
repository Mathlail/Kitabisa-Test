//
//  UserDefaultsHelper.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    enum Key: String {
        case favorites
    }
    
    func saveToUserDefaults<T: Codable>(object: T, key: Key) {
        if let encoded = try? JSONEncoder().encode(object) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    func loadUserDefaults<T: Codable>(expectedObject: T.Type, key: Key) -> T? {
        if let savedObject = UserDefaults.standard.object(forKey: key.rawValue) as? Data {
            guard let loadedObject = try? JSONDecoder().decode(expectedObject, from: savedObject) else { return nil }
                return loadedObject
        }
        return nil
    }
}
