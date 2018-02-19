//
//  AddCardViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

protocol ChosenDeck  {
    func didChooseDeck(deck: String)
}

class AddCardViewController: UIViewController, ChosenDeck {
   
    

    var ref: DatabaseReference!
    var currentDeckToModify: String!
//    var chosenDeck: String!
    let addCardView = AddCardView()
//    let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addCardToDeck))
    let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "savedCardPlus"), style: .plain, target: self, action: #selector(addCardToDeck))
    
    var deckHolder = [Decks]()
    
    init(decks: [Decks]) {
        super.init(nibName: nil, bundle: nil)
        self.deckHolder = decks
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func didChooseDeck(deck: String) {
        currentDeckToModify = deck
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddCardView()
        self.navigationItem.rightBarButtonItem = addButton
        addCardView.selectDeckButton.addTarget(self, action: #selector(viewDeckTitles), for: .touchUpInside)
        self.navigationItem.title = "Add Card"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpButtonTitle()
    }

    private func setUpButtonTitle() {
        let listOfDecksButton = addCardView.selectDeckButton
        if currentDeckToModify == nil {
            listOfDecksButton.setTitle("Choose A Deck", for: .normal)
        }
        else {
            listOfDecksButton.setTitle(currentDeckToModify, for: .normal)
        }
    }
 
    private func setUpAddCardView() {
        self.view.addSubview(addCardView)
        addCardView.snp.makeConstraints { (acView) in
            acView.size.equalTo(self.view.snp.size)
        }
    }

    @objc private func addCardToDeck() {
        guard let question = addCardView.questionTextField.text, !question.isEmpty else { print("Blank question field"); return }
        guard let answer = addCardView.answerTextField.text, !answer.isEmpty else { print("Answer field is blank"); return }
        self.ref = Database.database().reference()
        var cardRef = ""
//        let newFlashCard = Cards(ref: ref, question: question, answer: answer)
        let newFlashCard = Cards(ref: ref, question: question, answer: answer, timesCorrect: 0, cardRef: cardRef)
        if let currentUser = Auth.auth().currentUser, currentDeckToModify != nil {
            let newCard = self.ref.child("users/\(currentUser.uid)/cards").child(currentDeckToModify).childByAutoId()
            cardRef = newCard.key
            newCard.setValue(newFlashCard.toAnyObject())
            newCard.updateChildValues(["cardRef" : cardRef])
     
        }
//        let newCorrectGuess = CorrectGuess(ref: ref, correctGuesses: 0)
//        if let currentUser = Auth.auth().currentUser, newFlashCard != nil {
//            let newTimesCorrect = self.ref.child("users/\(currentUser.uid)/timesCorrect").child(currentDeckToModify).child(newFlashCard.question)
//            newTimesCorrect.setValue(newCorrectGuess.toAnyObject())
//        }
        addCardView.questionTextField.text = ""
        addCardView.answerTextField.text = ""
    
    }
    
    @objc private func viewDeckTitles() {
       let listVC = ListOfDecksTableViewController(decks: deckHolder)
        listVC.delegate = self
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
