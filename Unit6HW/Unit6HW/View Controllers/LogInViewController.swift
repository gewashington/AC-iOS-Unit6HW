//
//  LogInViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class LogInViewController: UIViewController {
    
    let loginView = LogInView()
    
    private var firebaseAuth = FirebaseAuthorization()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
        setUpLoginView()
        view.backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        loginView.noAccountButton.addTarget(self, action: #selector(presentCreateAccountVC), for: .touchUpInside)
        loginView.signInButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginView.passwordTextField.delegate = self
        firebaseAuth.delegate = self
       
    }
    
    private func setUpLoginView() {
        loginView.snp.makeConstraints { (loginV) in
            loginV.size.equalTo(self.view.safeAreaLayoutGuide.snp.size)
        }
    }
    
    @objc private func presentCreateAccountVC() {
        let createVC = CreateAccountViewController()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    @objc private func login() {
        guard let email = loginView.emailTextField.text else { print("email is nil"); return }
        print("Got here")
        guard !email.isEmpty else { print("email is blank"); return }
        guard let password = loginView.passwordTextField.text else { print("email is nil"); return }
        guard !password.isEmpty else { print("email is blank"); return }
        firebaseAuth.login(email: email, password: password)
    }
}

extension LogInViewController: FirebaseAPIDelegate {
    func didSignIn(_ userService: FirebaseAuthorization, user: User) {
        let categoryVC = UINavigationController(rootViewController: CategoriesViewController())
        print("Logged in ")
        present(categoryVC, animated: true, completion: nil)
    }
    
    func didFailSigningIn(_ userService: FirebaseAuthorization, error: Error) {
        showAlert(title: "Signin Error", message: error.localizedDescription)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okCancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okCancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        login()
        return false
    }
}

