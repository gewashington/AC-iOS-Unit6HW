//
//  CreateAccountViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class CreateAccountViewController: UIViewController {
    
    let createV = CreateAccountView()
    
    private var firebaseAuth = FirebaseAuthorization()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        //For view
        view.addSubview(createV)
        setUpCreateV()
        //Add delegate to...delegate
        firebaseAuth.delegate = self
        createV.alreadyHaveAccountButton.addTarget(self, action: #selector(presentLoginVC), for: .touchUpInside)
        createV.createAccountButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        createV.passwordTextField.delegate = self
    }
    
    private func setUpCreateV() {
        createV.snp.makeConstraints { (caView) in
            caView.size.equalTo(self.view.safeAreaLayoutGuide.snp.size)
            
        }
    }
    
    @objc private func presentLoginVC() {
        let loginVC = LogInViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func signUp() {
        guard let username = createV.usernameTextField.text, !username.isEmpty else { print("Username is empty"); return }
        guard let email = createV.emailTextField.text, !email.isEmpty else { print("Email is nil"); return }
        guard let password = createV.passwordTextField.text, !password.isEmpty else { print("Password is nil"); return }
        firebaseAuth.createUser(username: username, email: email, password: password)
    }
    
}

extension CreateAccountViewController: FirebaseAPIDelegate{
    func didCreateUser(_ userService: FirebaseAuthorization, user: User) {
        print("Created Account")
        let alertController = UIAlertController(title: "Account Created", message: "Thank you for registering. Enjoy your learning!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let categoryVC = CategoriesViewController()
            self.present(categoryVC, animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didFailCreatingUser(_ userService: FirebaseAuthorization, error: Error) {
        showAlert(title: "Error Creating Account", message: error.localizedDescription)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okCancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okCancel)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension CreateAccountViewController: UITextFieldDelegate {
    //Turn into global function?
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signUp()
        return false
    }
}
