//
//  LogInOrCreateAccountView.swift
//  Unit6HW
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit

class LogInOrCreateAccountView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "flashcardlogo")
        return iv
    }()
    
    lazy var logInButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Log In", for: .normal)
        butt.titleLabel?.textAlignment = .center
        butt.layer.borderColor = UIColor.white.cgColor
        butt.layer.borderWidth = 1.0
        butt.layer.cornerRadius = 2.0
        return butt
    }()
    
    lazy var createAccountButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Create Account", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.layer.borderColor = UIColor.white.cgColor
        butt.layer.borderWidth = 1.0
        butt.layer.cornerRadius = 2.0
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
        backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0) /* #339cff */
        setupViews()
    }
    
    private func setupViews() {
        let views = [logoImageView, logInButton, createAccountButton] as [UIView]
        views.forEach { addSubview($0) }
        setUpLogo()
        setUpLogInButton()
        setUpCreateButton()
    }
    
    private func setUpLogo() {
        logoImageView.snp.makeConstraints { (logo) in
            logo.top.equalTo(self.snp.top)
            logo.width.equalTo(self.snp.width)
            logo.height.equalTo(self.snp.height).multipliedBy(0.5)
           
            
        }
    }
    
    private func setUpLogInButton() {
        logInButton.snp.makeConstraints { (button) in
            button.height.equalTo(self.snp.height).multipliedBy(0.05)
            button.width.equalTo(self.snp.width).multipliedBy(0.5)
            button.top.equalTo(logoImageView.snp.bottom).offset(30)
            button.centerX.equalTo(logoImageView.snp.centerX)
            
        }
    }
    
    private func setUpCreateButton() {
        createAccountButton.snp.makeConstraints { (button) in
            button.height.equalTo(self.snp.height).multipliedBy(0.05)
            button.width.equalTo(self.snp.width).multipliedBy(0.5)
            button.top.equalTo(logInButton.snp.bottom).offset(15)
            button.centerX.equalTo(logoImageView.snp.centerX)
    }
    
}

}
