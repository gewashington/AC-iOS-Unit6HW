//
//  QuizWithCardsViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class QuizWithCardsViewController: UIViewController {
    
    var cards = [Cards]() {
        didSet{
            print("It set!")
            quizView.questionTextView.text = cards.first?.question
            quizView.answerTextView.text = cards.first?.answer
        }
    }
    
    var currentUser: User!
    var currentDeckTitle: String!
    var currentCard: Int!
    
    let quizView = QuizWithCardsView()
    let quizButtons = QuizButtonView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        setViews()
        currentUser = Auth.auth().currentUser
        loadCards()
        
    }
    
    init(deckTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.currentDeckTitle = deckTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setViews() {
        view.addSubview(quizView)
        view.addSubview(quizButtons)
        quizView.snp.makeConstraints { (quiz) in
            quiz.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            quiz.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            quiz.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
        }
        quizButtons.snp.makeConstraints { (butt) in
            butt.top.equalTo(quizView.snp.bottom)
            butt.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            butt.width.equalTo(view.safeAreaLayoutGuide.snp.width)
        }
        quizView.answerTextView.isHidden = true
        quizButtons.rightButton.isHidden = true
        quizButtons.wrongButton.isHidden = true
        
        quizButtons.showAnswerButton.addTarget(self, action: #selector(showAnswer), for: .touchUpInside)
        quizButtons.rightButton.addTarget(self, action: #selector(correctAnswer), for: .touchUpInside)
        quizButtons.wrongButton.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
    }
    
    func loadCards() {
        DatabaseService.shared.getCards(from: currentUser, from: currentDeckTitle) { (onlineCards) in
            let safeCards = onlineCards
            self.cards = safeCards
        }
    }
    
    @objc private func showAnswer() {
        quizView.answerTextView.isHidden =  false
        quizButtons.rightButton.isHidden = false
        quizButtons.wrongButton.isHidden = false
        quizButtons.showAnswerButton.isHidden = true
    }
    
    @objc private func correctAnswer() {
        quizView.answerTextView.isHidden = true
        quizButtons.rightButton.isHidden = true
        quizButtons.wrongButton.isHidden = true
        quizButtons.showAnswerButton.isHidden = false
        nextQuestion()
        //Add code to add correct answer points
        //Add code to move to next question
    }
    
    @objc private func wrongAnswer() {
        quizView.answerTextView.isHidden = true
        quizButtons.rightButton.isHidden = true
        quizButtons.wrongButton.isHidden = true
        quizButtons.showAnswerButton.isHidden = false
        nextQuestion()
        //Add code to move to next question
    }
    
    private func nextQuestion() {
        var cardIterator = cards.makeIterator()
        while let card = cardIterator.next() {
            quizView.questionTextView.text = card.question
            quizView.answerTextView.text = card.answer

        }

    
        
        
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
