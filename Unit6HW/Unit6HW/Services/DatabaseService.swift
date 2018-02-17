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
                let deckModel = Decks(snapShot: child as! DataSnapshot)
                decks.append(deckModel)
            }
            completion(decks)

        }
        
}

    public func getCards(from user: User, from deck: String, completion: @escaping([Cards]) -> Void) {
        deckRef.child(user.uid).child("cards/\(deck)").observe(.value) { (snapshot) in
            var cards = [Cards]()
            for child in snapshot.children {
                let cardModel = Cards(snapShot: child as! DataSnapshot)
                cards.append(cardModel)
            }
            completion(cards)
        }
    }

//    guard; let user = Auth.auth().currentUser else { print("Error: No user"); return
//
//    }
//    let categoryRef = Database.database().reference().child("categories")
//    let categoryRef = Database.database().reference().child("users").child("\(Auth.auth().currentUser!.uid)").child("categories")

}
