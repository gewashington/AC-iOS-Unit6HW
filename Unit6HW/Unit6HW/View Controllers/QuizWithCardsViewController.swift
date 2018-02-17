//
//  QuizWithCardsViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit

class QuizWithCardsViewController: UIViewController {

    var cards = [Cards]()
    
    let quizView = QuizWithCardsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
       setUpQuizView()
        quizView.answerTextView.isHidden = true
    }
    
    private func setUpQuizView() {
        view.addSubview(quizView)
        quizView.snp.makeConstraints { (quiz) in
            quiz.top.equalTo(view.safeAreaLayoutGuide.snp.top)
           quiz.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            quiz.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
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
