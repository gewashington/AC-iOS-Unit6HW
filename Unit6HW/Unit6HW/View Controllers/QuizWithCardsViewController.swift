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

/*To load and save correct answer:
 - When card is created, correctGuess is created
 - Correct answer must load when VC loads the first card
 - Load correct amount of guess for next question
 - When user clicks that they got it right, correct answer += 1, correctAnswers is set to the correctAnswers saved to the next card which is being loaded
 */

class QuizWithCardsViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var cards = [Cards]() {
        didSet{
            print("It set!")
//            quizView.questionTextView.text = cards.first?.question
//            quizView.answerTextView.text = cards.first?.answer
//            correctAnswers = (cards.first?.timesCorrect)!
            quizView.questionTextView.text = cards[currentCard].question
            quizView.answerTextView.text = cards[currentCard].answer
            correctAnswers = cards[currentCard].timesCorrect
        
        }
    }
    
    var currentUser: User!
    var currentDeckTitle: String!
    var currentCard = 0
    var correctAnswers = Int()
//    {
//        willSet {
//            print("It didSet")
//        }
//    }
    
    var question = String() {
        didSet {
            question = cards[currentCard].question
        }
    }
    
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
        quizView.timesCorrectLabel.isHidden = true
        
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
    
//    func loadCorrectGuessForCurrentQuestion() {
//        DatabaseService.shared.getAnsweredCorrectlyAmount(from: currentUser, in: currentDeckTitle, referring: question) { (onlineGuess) in
//            let safeGuess = onlineGuess
//            self.correctAnswers = safeGuess
//        }
//    }
    
    @objc private func showAnswer() {
        quizView.answerTextView.isHidden =  false
        quizButtons.rightButton.isHidden = false
        quizButtons.wrongButton.isHidden = false
        quizButtons.showAnswerButton.isHidden = true
        quizView.timesCorrectLabel.isHidden = false
        quizView.timesCorrectLabel.text = "Times Answered Correctly: \(cards[currentCard].timesCorrect)"
    }
    
    @objc private func correctAnswer() {
//        loadCorrectGuessForCurrentQuestion()
        correctAnswers += 1
        self.ref = Database.database().reference()
        let guessCounter = self.ref.child("users/\(currentUser.uid)/cards/\(currentDeckTitle!)/\(cards[currentCard].cardRef)")
        guessCounter.updateChildValues(["timesCorrect": correctAnswers])
        nextQuestion()
        quizView.answerTextView.isHidden = true
        quizButtons.rightButton.isHidden = true
        quizButtons.wrongButton.isHidden = true
        quizButtons.showAnswerButton.isHidden = false
        quizView.timesCorrectLabel.isHidden = true
//        guessCounter.child("correctGuesses").setValue(correctAnswers)
        
    }
    
    @objc private func wrongAnswer() {
        quizView.answerTextView.isHidden = true
        quizButtons.rightButton.isHidden = true
        quizButtons.wrongButton.isHidden = true
        quizView.timesCorrectLabel.isHidden = true
        quizButtons.showAnswerButton.isHidden = false
        
        nextQuestion()
        
    }
    
    @objc private func nextQuestion() {
        if currentCard == cards.count - 1 {
            currentCard = 0
        }
        else {
            currentCard += 1
            
        }
        quizView.questionTextView.text = cards[currentCard].question
        quizView.answerTextView.text = cards[currentCard].answer
        correctAnswers = cards[currentCard].timesCorrect
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
