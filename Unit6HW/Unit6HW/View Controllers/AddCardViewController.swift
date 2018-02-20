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

    let addCardView = AddCardView()

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
        self.navigationItem.title = "Add Card"
        addCardView.selectDeckButton.addTarget(self, action: #selector(viewDeckTitles), for: .touchUpInside)
        addCardView.answerTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpButtonTitle()
    }

    private func setUpButtonTitle() {
        let listOfDecksButton = addCardView.selectDeckButtonLabel
        if currentDeckToModify == nil {
            listOfDecksButton.text = "Choose A Deck"
        }
        else {
            listOfDecksButton.text = currentDeckToModify
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
        let newFlashCard = Cards(ref: ref, question: question, answer: answer, timesCorrect: 0, cardRef: cardRef)
        if let currentUser = Auth.auth().currentUser, currentDeckToModify != nil {
            let newCard = self.ref.child("users/\(currentUser.uid)/cards").child(currentDeckToModify).childByAutoId()
            cardRef = newCard.key
            newCard.setValue(newFlashCard.toAnyObject())
            newCard.updateChildValues(["cardRef" : cardRef])
     
            //Alert for adding card
            let alertVC = UIAlertController(title: "Card Created", message: "The card has been added to the deck.", preferredStyle: .alert)
            alertVC.view.layoutIfNeeded()
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
            
        }

        addCardView.questionTextField.text = ""
        addCardView.answerTextField.text = ""
    
    }
    
    @objc private func viewDeckTitles() {
       let listVC = ListOfDecksTableViewController(decks: deckHolder)
        listVC.delegate = self
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    

}

extension AddCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCardToDeck()
        return false
    }
}
