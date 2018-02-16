//
//  DatabaseService.swift
//  Unit6HW
//
//  Created by C4Q on 2/14/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class DatabaseService {
    private init() {
        dbRef = Database.database().reference()
        deckRef = dbRef.child("users")
        currentUser = Auth.auth().currentUser!
    }
    static let shared = DatabaseService()
    private var dbRef: DatabaseReference!
    //put private back after done observing
    var deckRef: DatabaseReference!
    private var currentUser: User!
    
    
    
    public func getDecks(from user: User, completion: @escaping([Decks]) -> Void) {
        deckRef.child(user.uid).child("categories").observe(.value) { (snapshot) in
            var decks = [Decks]()
            for child in snapshot.children {
                let decModel = Decks(snapShot: child as! DataSnapshot)
                decks.append(decModel)
            }
            completion(decks)
//            let deckModel = Decks(snapShot: client as! DataSnapshot)
//            if user.uid == deckModel.ref.key {
//                decks.insert(deckModel, at: 0)
//            }
        }
        //        deckRef.observe(.value) { (snapshot) in
        //            for client in snapshot.children {
        //               let deckModel = Decks(snapShot: client as! DataSnapshot)
        //                if user.uid == deckModel.ref.key {
        //                    decks.insert(deckModel, at: 0)
        //                }
        
        
    

}


//    guard; let user = Auth.auth().currentUser else { print("Error: No user"); return
//
//    }
//    let categoryRef = Database.database().reference().child("categories")
//    let categoryRef = Database.database().reference().child("users").child("\(Auth.auth().currentUser!.uid)").child("categories")

}
