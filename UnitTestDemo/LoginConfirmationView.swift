//
//  LoginConfirmationView.swift
//  UnitTestingALogin
//
//  Created by Sam LoBue on 5/16/21.
//

import UIKit

class LoginConfirmationView: UIView, ButtonTapping {
    
    private let noMusicImageView: UIImageView = {
        let noMusicImageView = UIImageView()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .large)
        noMusicImageView.image = UIImage(systemName: "person.crop.circle", withConfiguration: largeConfig)
        noMusicImageView.tintColor = .black
        noMusicImageView.contentMode = .scaleAspectFit
        return noMusicImageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = Constants.welcome
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let resetStateButton: UIButton = {
        let resetStateButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .large)
        resetStateButton.setImage(UIImage(systemName: "delete.left.fill", withConfiguration: largeConfig), for: .normal)
        resetStateButton.tintColor = .black
        resetStateButton.addTarget(self, action: #selector(clearUserDefaults), for: .touchUpInside)
        return resetStateButton
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginButton.setTitle(Constants.chooseAProfile, for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = [Constants.student, Constants.teacher]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.isHidden = false
        return segmentControl
    }()
    
    var delegate: ButtonTapping?
    
    // MARK: - LIFECYCLE
    public override init(frame: CGRect) {
        super.init(frame: frame)
        constructSubviews()
        constructSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    func constructSubviews() {
        addSubview(resetStateButton)
        addSubview(noMusicImageView)
        addSubview(titleLabel)
        addSubview(loginButton)
        addSubview(segmentedControl)
    }
    
    func constructSubviewConstraints() {
        let views = [resetStateButton, noMusicImageView, titleLabel, loginButton, segmentedControl]
        
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        // loginButton
        NSLayoutConstraint.activate([
            resetStateButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            resetStateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        // noMusicImageView
        NSLayoutConstraint.activate([
            noMusicImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            noMusicImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noMusicImageView.heightAnchor.constraint(equalToConstant: 125),
            noMusicImageView.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: noMusicImageView.bottomAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // segmentedControl
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            segmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func didTapButton(loginKey: LoginKeys) {}
    
    @objc
    func loginButtonTapped() {
        if segmentedControl.selectedSegmentIndex == 0 {
            styleForStudent()
            delegate?.didTapButton(loginKey: .isStudent)
        } else {
            styleForTeacher()
            delegate?.didTapButton(loginKey: .isTeacher)
        }
    }
    
    @objc
    func clearUserDefaults() {
        delegate?.didTapButton(loginKey: .clear)
        styleForOnboarding()
    }

    
    func styleForTeacher() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .large)
        noMusicImageView.image = UIImage(systemName: "person.crop.circle.fill.badge.checkmark", withConfiguration: largeConfig)
        noMusicImageView.tintColor = .systemGreen
        loginButton.isEnabled = false
        loginButton.setTitle(Constants.teacher, for: .normal)
        segmentedControl.isHidden = true
    }

    func styleForStudent() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .large)
        noMusicImageView.image = UIImage(systemName: "person.crop.circle.fill.badge.checkmark", withConfiguration: largeConfig)
        noMusicImageView.tintColor = .systemGreen
        loginButton.isEnabled = false
        loginButton.setTitle(Constants.student, for: .normal)
        segmentedControl.isHidden = true
    }
    
    func styleForOnboarding() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .large)
        noMusicImageView.image = UIImage(systemName: "person.crop.circle", withConfiguration: largeConfig)
        noMusicImageView.tintColor = .black
        loginButton.isEnabled = true
        loginButton.setTitle(Constants.chooseAProfile, for: .normal)
        segmentedControl.isHidden = false
    }
}

protocol ButtonTapping {
    func didTapButton(loginKey: LoginKeys)
}


struct Constants {
    static let chooseAProfile = "Choose a profile"
    static let clear = "clearUserDefaults"
    static let isStudent = "isStudent"
    static let isTeacher = "isTeacher"
    static let student = "Student"
    static let teacher = "Teacher"
    static let welcome = "Welcome"
}
