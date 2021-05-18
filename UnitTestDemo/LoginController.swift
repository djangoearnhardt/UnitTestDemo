//
//  LoginController.swift
//  UnitTestingALogin
//
//  Created by Sam LoBue on 5/16/21.
//

import Foundation

/// LoginController saves Login state for a client.
///
/// When a Student or a Teacher logins, LoginController tracks their state.
class LoginController {
    
    // MARK: - SINGLETON
    static let sharedInstance = LoginController()
    
    // MARK: - PROPERTIES
    var userDefaults: UserDefaults = UserDefaults.standard
    
    var isStudent: Bool {
        userDefaults.bool(forKey: LoginKeys.isStudent.rawValue)
    }

    var isTeacher: Bool {
        userDefaults.bool(forKey: LoginKeys.isTeacher.rawValue)
    }
    
    // MARK: - FUNCTIONS
    func saveAsStudent() {
        userDefaults.set(true, forKey: LoginKeys.isStudent.rawValue)
    }
    
    func saveAsTeacher() {
        userDefaults.set(true, forKey: LoginKeys.isTeacher.rawValue)
    }
    
    func clearLoginKeys() {
        LoginKeys.allCases.forEach { userDefaults.removeObject(forKey: $0.rawValue) }
    }
}

enum LoginKeys: String, CaseIterable {
    case clear
    case isStudent
    case isTeacher
    
    var rawValue: String {
        switch self {
        case .clear:
            return Constants.clear
        case .isStudent:
            return Constants.isStudent
        case .isTeacher:
            return Constants.isTeacher
        }
    }
}
