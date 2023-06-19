//
//  UserObject.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import Foundation

class UserObject {
    
    private let defaults = UserDefaults.standard
    
    func setValue(value: Any, forKey key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func removeObject(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    func getObject(forKey key: String) -> Any? {
        defaults.object(forKey: key)
    }
    
    struct Constants {
        static let token = "token"
        static let gender = "gender"
        static let isPremium = "isPremium"
        static let userEmail = "userEmail"
        static let userContact = "userContact"
    }
}

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case token
        case gender
    }
    
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
