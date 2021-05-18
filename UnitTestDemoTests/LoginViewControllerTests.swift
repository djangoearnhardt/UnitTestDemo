//
//  LoginViewControllerTests.swift
//  UnitTestDemoTests
//
//  Created by Sam LoBue on 5/18/21.
//

@testable import UnitTestDemo
import XCTest

class LoginViewControllerTests: XCTestCase {

    var loginViewController: LoginViewController?
    var loginController: LoginControlling?
    var customUserDefaults: UserDefaults?
    let customSuiteName = "testLoginController"
    let testKey = "testKey"
    
    override func setUp() {
        // Initialize customUserDefaults and a LoginController
        self.customUserDefaults = UserDefaults(suiteName: customSuiteName)
    }
    
    override func tearDown() {
        // Remove customUserDefaults and LoginController from memory
        UserDefaults().removePersistentDomain(forName: customSuiteName)
        loginController = nil
        loginViewController = nil
    }
    
    func prepareLoginController(with loginKey: LoginKeys?) {
        guard let customUserDefaults = customUserDefaults else {
            XCTFail("CustomUserDefaults failed to initialize")
            return
        }
        loginController = LoginController(userDefaults: customUserDefaults)
        
        guard let loginController = loginController else {
            XCTAssertNotNil(loginController, "LoginController failed to initialize")
            return
        }
        
        switch loginKey {
        case .isStudent:
            loginController.saveAsStudent()
        case .isTeacher:
            loginController.saveAsTeacher()
        default:
            break
        }
        loginViewController = LoginViewController(loginController: loginController)
    }

    func testThatLoginShowsTeacherUI() {
        // GIVEN
        // A Student has logged in before
        prepareLoginController(with: .isTeacher)
        guard let loginViewController = loginViewController else {
            XCTFail("LoginViewController failed to initialize")
            return
        }
        
        // WHEN
        loginViewController.styleForLogInResult()
        
        let uiDelayExpectation = expectation(description: "Waiting for UI update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                uiDelayExpectation.fulfill()
            }
        
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssert(loginViewController.loginConfirmationView.segmentedControl.isHidden == true)
    }
    
    func testThatLoginShowsStudentUI() {
        // GIVEN
        // A Student has logged in before
        prepareLoginController(with: .isStudent)
        guard let loginViewController = loginViewController else {
            XCTFail("LoginViewController failed to initialize")
            return
        }
                
        // WHEN
        loginViewController.styleForLogInResult()
        
        let uiDelayExpectation = expectation(description: "Waiting for UI update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            uiDelayExpectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssert(loginViewController.loginConfirmationView.segmentedControl.isHidden == true)
    }
    
    func testThatLoginShowsOnboarding() {
        // GIVEN
        // A Student has logged in before
        prepareLoginController(with: nil)
        guard let loginViewController = loginViewController else {
            XCTFail("LoginViewController failed to initialize")
            return
        }
        
        // WHEN
        loginViewController.styleForLogInResult()
        
        let uiDelayExpectation = expectation(description: "Waiting for UI update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                uiDelayExpectation.fulfill()
            }
        
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssert(loginViewController.loginConfirmationView.segmentedControl.isHidden == false)
    }
}
