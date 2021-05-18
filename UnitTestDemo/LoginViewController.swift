//
//  LoginViewController.swift
//  UnitTestingALogin
//
//  Created by Sam LoBue on 5/16/21.
//

import UIKit

class LoginViewController: UIViewController, ButtonTapping {

    // MARK: - PROPERTIES
    let loginConfirmationView: LoginConfirmationView = LoginConfirmationView()
    
    let loginController: LoginController = LoginController.sharedInstance
    
    // MARK: - LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        styleForLogInResult()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginConfirmationView.delegate = self
        constructAndConstraintSubview()
    }
    
    // MARK: - FUNCTIONS
    func constructAndConstraintSubview() {
        view.addSubview(loginConfirmationView)
        loginConfirmationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginConfirmationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginConfirmationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginConfirmationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginConfirmationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func styleForLogInResult() {
        if loginController.isTeacher == true {
            DispatchQueue.main.async {
                self.loginConfirmationView.styleForTeacher()
            }
        } else if loginController.isStudent == true {
            DispatchQueue.main.async {
                self.loginConfirmationView.styleForStudent()
            }
        } else {
            DispatchQueue.main.async {
                self.loginConfirmationView.styleForOnboarding()
            }
        }
    }
    
    func didTapButton(loginKey: LoginKeys) {
        switch loginKey {
        case .clear:
                loginController.clearLoginKeys()
        case .isStudent:
                loginController.saveAsStudent()
        case .isTeacher:
                loginController.saveAsTeacher()
        }
    }
}
