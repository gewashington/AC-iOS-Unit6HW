//
//  CorrectGuessModel.swift
//  Unit6HW
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct CorrectGuess {
    let ref: DatabaseReference
    let correctGuesses: Int
    
    init(ref: DatabaseReference, correctGuesses: Int) {
        self.ref = ref
        self.correctGuesses = correctGuesses
    }
    
    init(snapShot: DataSnapshot)  {
        let value = snapShot.value as? [String:Any]
        self.ref = snapShot.ref
        self.correctGuesses = value?["correctGuesses"] as? Int ?? 0 
    }
    
    func toAnyObject() -> [String:Any] {
        return ["correctGuesses": correctGuesses]
    }
}
