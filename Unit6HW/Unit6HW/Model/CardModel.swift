//
//  CardModel.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct Cards {
    let ref: DatabaseReference
    let question: String
    let answer: String
    
    init(ref: DatabaseReference, question: String, answer: String) {
        self.ref = ref
        self.question = question
        self.answer = answer
    }
    
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String : Any]
        self.ref = snapShot.ref
        self.question = value?["question"] as? String ?? ""
        self.answer = value?["answer"] as? String ?? ""
    }
    
    func toAnyObject() -> [String : Any] {
        return ["question": question, "answer" : answer ]
    }
    
    
}
