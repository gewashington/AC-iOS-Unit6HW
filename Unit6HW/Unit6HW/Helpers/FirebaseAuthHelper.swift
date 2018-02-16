//
//  FirebaseHelper.swift
//  Unit6HW
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

@objc protocol FirebaseAPIDelegate: class {
    //create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: FirebaseAuthorization, error: Error)
    @objc optional func didCreateUser(_ userService: FirebaseAuthorization, user: User)
    
    //log in delegate protocols
    @objc optional func didFailSigningIn(_ userService: FirebaseAuthorization, error: Error)
    @objc optional func didSignIn(_ userService: FirebaseAuthorization, user: User )
    
    //log out delegate protocols
    @objc optional func didFailSigningOut(_ userService: FirebaseAuthorization, error: Error)
    @objc optional func didSignout(_ userService: FirebaseAuthorization)
}


class FirebaseAuthorization: NSObject {
    weak var delegate: FirebaseAPIDelegate?
    
    public func createUser(username: String, email: String, password: String) {
        let ref = Database.database().reference().root
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error  {
                self.delegate?.didFailCreatingUser?(self, error: error)
            }
            else if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Error Changing Display Name: \(error.localizedDescription)")
                    }
                    else {
                        print("Display Name Added.")
                        self.delegate?.didCreateUser?(self, user: user)
                        ref.child("users").child((user.uid)).setValue(email)
                    }
                }
                )
                
            }
        }
    }
    public func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailSigningIn?(self, error: error)
            }
            else if let user = Auth.auth().currentUser {
                self.delegate?.didSignIn?(self, user: user)
                print("User is signing in")
            }
        }
    }
    
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    
    public func signOut() {
        do {
            try! Auth.auth().signOut()
            self.delegate?.didSignout?(self)
        }
//        catch {
//            print(error)
//            self.delegate?.didFailSigningOut?(self, error: error)
//        }
    }
    
}


