//
//  UserDefaultsUtility.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import Foundation


extension UserDefaults {
    func set(_ value:Any?,forKey: UserDefaultUtility.UDConstant) {
        UserDefaults.standard.set(value, forKey: forKey.rawValue)
    }
    func value(_ forKey:UserDefaultUtility.UDConstant) -> Any? {
      return  UserDefaults.standard.value(forKey: forKey.rawValue)
    }
}

struct UserDefaultUtility
{
    var userID : Int {
        set{
            UserDefaults.standard.set(newValue, forKey: .saveUserId)
        }
        
        get {
            return(UserDefaults.standard.value(.saveUserId) as? Int) ?? 0
        }
    }
    
}

extension UserDefaultUtility {
    // UserDefaults Constant keys
    public enum UDConstant : String {
        case saveUserId
    }
}
