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
    
    let loginController: LoginControlling?
    
    // MARK: - LIFECYCLE
    init(loginController: LoginControlling = LoginController.sharedInstance) {
        self.loginController = loginController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        loginController = LoginController.sharedInstance
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        styleForLogInResult {}
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
    
    func styleForLogInResult(completion: @escaping () -> Void) {
        if loginController?.isTeacher == true {
            DispatchQueue.main.async {
                self.loginConfirmationView.styleForTeacher()
                completion()
            }
        } else if loginController?.isStudent == true {
            DispatchQueue.main.async {
                self.loginConfirmationView.styleForStudent()
                completion()
            }
        } else {
            DispatchQueue.main.async {
                self.loginConfirmationView.styleForOnboarding()
                completion()
            }
        }
    }
    
    func didTapButton(loginKey: LoginKeys) {
        switch loginKey {
        case .clear:
                loginController?.clearLoginKeys()
        case .isStudent:
                loginController?.saveAsStudent()
        case .isTeacher:
                loginController?.saveAsTeacher()
        }
    }
}
