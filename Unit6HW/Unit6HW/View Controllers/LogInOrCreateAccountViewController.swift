//
//  LogInOrCreateAccountViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

class LogInOrCreateAccountViewController: UIViewController {
    
    let vcvView = LogInOrCreateAccountView()
    
    let fireAuth = FirebaseAuthorization()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //For view
        view.addSubview(vcvView)
        view.backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        //turn into global function?
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        navBar?.tintColor = .white
        navBar?.isTranslucent = false
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        
        setUpViewConstraints()
        vcvView.logInButton.addTarget(self, action: #selector(switchToLoginVC), for: .touchUpInside)
        vcvView.createAccountButton.addTarget(self, action: #selector(switchToCreateVC), for: .touchUpInside)
    }
    

    func setUpViewConstraints() {
        vcvView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view.snp.size)
        }
    }
    
    @objc private func switchToLoginVC() {
        let loginVC = LogInViewController()
        
//        let navLoginVC = UINavigationController(rootViewController: loginVC)
//        present(loginVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func switchToCreateVC() {
        let createVC = CreateAccountViewController()
//        let navCreateVC = UINavigationController(rootViewController: createVC)
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    


}
