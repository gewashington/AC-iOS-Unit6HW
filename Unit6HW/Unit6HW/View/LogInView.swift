//
//  LogInView.swift
//  Unit6HW
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit

class LogInView: UIView {
    
    lazy var loginTitleLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Welcome Back"
        lab.numberOfLines = 0
        lab.textAlignment = .center
        lab.textColor = .white
        lab.font = UIFont(name: "Gill Sans", size: 25)
        return lab
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        underLine(from: tf)
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.isSecureTextEntry = true
        underLine(from: tf)
        return tf
    }()
    
    lazy var signInButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Sign In", for: .normal)
        butt.titleLabel?.textAlignment = .center
        butt.layer.borderColor = UIColor.white.cgColor
        butt.layer.borderWidth = 1.0
        butt.layer.cornerRadius = 2.0
        //not sure if keeping background color for button
//        butt.backgroundColor = UIColor(red: 92/255, green: 163/255, blue: 230/255, alpha: 1.0)
        return butt
    }()
    
    lazy var noAccountButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Need an account? Click here.", for: .normal)
        butt.titleLabel?.textAlignment = .center
        butt.titleLabel?.font = UIFont(name: "Gill Sans", size: 12)
        return butt
    }()

        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        private func commonInit() {
            backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
            setupViews()
        }
        
        private func setupViews() {
            let views = [loginTitleLabel, emailTextField, passwordTextField, signInButton, noAccountButton] as [UIView]
            views.forEach { addSubview($0) }
            setUpLoginLabel()
            setUpEmailTF()
            setUpPasswordTF()
            setUpSignInButton()
            setUpNoAccountButton()
            
        }
    
    private func setUpLoginLabel() {
        loginTitleLabel.snp.makeConstraints { (lab) in
            lab.height.equalTo(self.snp.height).multipliedBy(0.2)
            lab.width.equalTo(self.snp.width).multipliedBy(0.8)
            lab.centerX.equalTo(self.snp.centerX)
            lab.top.equalTo(self.snp.top).offset(20)
        }
    }
    
    private func setUpEmailTF() {
        emailTextField.snp.makeConstraints { (tf) in
            tf.height.equalTo(self.snp.height).multipliedBy(0.05)
            tf.width.equalTo(self.snp.width).multipliedBy(0.6)
            tf.centerX.equalTo(self.snp.centerX)
            tf.top.equalTo(loginTitleLabel.snp.bottom).offset(30)
        }
        
    }
    
    private func setUpPasswordTF() {
        passwordTextField.snp.makeConstraints { (tf) in
            tf.height.equalTo(self.snp.height).multipliedBy(0.05)
            tf.width.equalTo(self.snp.width).multipliedBy(0.6)
            tf.centerX.equalTo(self.snp.centerX)
            tf.top.equalTo(emailTextField.snp.bottom).offset(15)
            
        }
    }
    
    private func setUpSignInButton() {
        signInButton.snp.makeConstraints { (button) in
            button.height.equalTo(self.snp.height).multipliedBy(0.05)
            button.width.equalTo(self.snp.width).multipliedBy(0.6)
            button.top.equalTo(passwordTextField.snp.bottom).offset(30)
            button.centerX.equalTo(loginTitleLabel.snp.centerX)
            
        }
    }

    private func setUpNoAccountButton() {
        noAccountButton.snp.makeConstraints { (button) in
            button.height.equalTo(self.snp.height).multipliedBy(0.05)
            button.width.equalTo(self.snp.width).multipliedBy(0.7)
            button.top.equalTo(signInButton.snp.bottom).offset(15)
            button.centerX.equalTo(loginTitleLabel.snp.centerX)
            
        }
    }
    
    func underLine(from txt: UITextField) {
        let border = UIView()
        border.backgroundColor = .white
        border.translatesAutoresizingMaskIntoConstraints = false
        txt.addSubview(border)
        border.heightAnchor.constraint(equalToConstant: 1).isActive = true
        border.widthAnchor.constraint(equalTo: txt.widthAnchor).isActive = true
        border.bottomAnchor.constraint(equalTo: txt.bottomAnchor, constant: -1).isActive = true
        border.leftAnchor.constraint(equalTo: txt.leftAnchor).isActive = true
    }

}
