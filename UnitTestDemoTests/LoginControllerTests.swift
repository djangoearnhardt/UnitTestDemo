//
//  LoginControllerTests.swift
//  UnitTestDemoTests
//
//  Created by Sam LoBue on 5/18/21.
//

@testable import UnitTestDemo
import XCTest

class LoginControllerTests: XCTestCase {

    var loginController: LoginController?
    var customUserDefaults: UserDefaults?
    let customSuiteName = "testLoginController"
    let testKey = "testKey"
    
    override func setUp() {
        // Initialize customUserDefaults and a LoginController
        self.customUserDefaults = UserDefaults(suiteName: customSuiteName)
        prepareLoginController()
    }
    
    override func tearDown() {
        // Remove customUserDefaults and LoginController from memory
        UserDefaults().removePersistentDomain(forName: customSuiteName)
    }
    
    func prepareLoginController() {
        guard let customUserDefaults = customUserDefaults else {
            XCTFail("CustomUserDefaults failed to initialize")
            return
        }
        loginController = LoginController(userDefaults: customUserDefaults)
    }
    
    // MARK: - TESTS
    func testThatCustomUserDefaultsInitializes() {
        // GIVEN
        // A UserDefaults object
        guard let customUserDefaults = customUserDefaults else {
            XCTFail("UserDefaults did not initialize")
            return
        }
        
        // THEN
        XCTAssertNotNil(customUserDefaults)
    }

    func testThatCustomUserDefaultsCanSaveACustomKey() {
        // GIVEN, WHEN
        // A custom UserDefaults object
        guard let customUserDefaults = self.customUserDefaults else {
            XCTFail("Could not initialize customUserDefaults")
            return
        }
        
        // THEN
        // A custom key should not exist
        XCTAssertFalse(customUserDefaults.bool(forKey: testKey))
        
        // WHEN
        // A custom key is set
        customUserDefaults.setValue(true, forKey: testKey)
        
        // THEN
        // A custom key should exist
        XCTAssertTrue(customUserDefaults.bool(forKey: testKey))
    }
    
    func testThatClearingLoginControllerKeysSucceeds() {
        // GIVEN
        // A LoginController
        guard let loginController = loginController else {
            XCTAssertNotNil(loginController, "LoginController failed to initialize")
            return
        }
        
        // WHEN
        // A User is marked as a Student
        loginController.saveAsStudent()
        
        // THEN
        // The LoginController should recognize the User as a Student
        XCTAssertTrue(loginController.isStudent)
        
        // WHEN
        // The LoginController LoginKeys are cleared
        loginController.clearLoginKeys()
        
        // THEN
        // The LoginController should not recognize the User as a Student
        XCTAssertFalse(loginController.isStudent)
        // The LoginController userDefaults should not have a value for a Student
        XCTAssertFalse(loginController.userDefaults.bool(forKey: LoginKeys.isStudent.rawValue))
        
        // WHEN
        // A User is marked as a Teacher
        loginController.saveAsTeacher()
        
        // THEN
        // The LoginController should recognize the User as a Teacher
        XCTAssertTrue(loginController.isTeacher)
        
        // WHEN
        // The LoginController LoginKeys are cleared
        loginController.clearLoginKeys()
        
        // THEN
        // The LoginController should not recognize the User as a Teacher
        XCTAssertFalse(loginController.isTeacher)
        // The LoginController userDefaults should not have a value for a Teacher
        XCTAssertFalse(loginController.userDefaults.bool(forKey: LoginKeys.isTeacher.rawValue))
    }
}
