//
//  UserDefaultsStorage.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation

protocol UserDefaultsStoring {
    func save(value: Any, forKey key: String)
    func remove(forKey key: String)
    func string(forKey key: String) -> String?
    func int(forKey key: String) -> Int
    func bool(forKey key: String) -> Bool
    func date(forKey key: String) -> Date?
    func dictionary(forKey key: String) -> [AnyHashable: Any]?
}

final class UserDefaultsStorage: UserDefaultsStoring {
    let defaults: UserDefaults
    
    // MARK: - Initialization
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    // MARK: UserDefaultsStoring
    func save(value: Any, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    func string(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    func int(forKey key: String) -> Int {
        return defaults.integer(forKey: key)
    }
    
    func bool(forKey key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return defaults.object(forKey: key) as? Date
    }
    
    func dictionary(forKey key: String) -> [AnyHashable: Any]? {
        return defaults.dictionary(forKey: key)
    }
}
