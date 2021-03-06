//
//  QuizWithCardsView.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit

class QuizWithCardsView: UIView {

    lazy var questionTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.text = "According to Greek mythology, who was the god of wine?"
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.font = UIFont(name: "Gill Sans", size: 20)
        tv.textAlignment = .center
        tv.adjustsFontForContentSizeCategory = true
        return tv
    }()
    
    lazy var answerTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.text = "Dionysos"
        tv.textColor = .white
        tv.backgroundColor = .clear
        tv.font = UIFont(name: "Gill Sans", size: 20)
        tv.textAlignment = .center
        tv.adjustsFontForContentSizeCategory = true
        return tv
    }()
    
    lazy var timesCorrectLabel: UILabel = {
        let lab = UILabel()
        lab.backgroundColor = .clear
        lab.font = UIFont(name: "Gill Sans", size: 15)
        lab.textAlignment = .center
        lab.textColor = .white
        
        return lab
    }()
    
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        private func commonInit() {
            backgroundColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
            setupViews()
        }
        
        private func setupViews() {
            let views = [questionTextView, answerTextView, timesCorrectLabel] as [UIView]
            views.forEach { addSubview($0)}
            setUpQuestionTV()
            setUpAnswerTV()
            setUpGuessCorrectLab()
        }
    
    private func setUpQuestionTV() {
        questionTextView.snp.makeConstraints { (tv) in
            tv.centerX.equalTo(self.snp.centerX)
            tv.top.equalTo(self.snp.top).offset(50)
            tv.width.equalTo(self.snp.width).multipliedBy(0.9)
            tv.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
    }
    
    private func setUpAnswerTV() {
        answerTextView.snp.makeConstraints { (tv) in
            tv.centerX.equalTo(self.snp.centerX)
            tv.top.equalTo(questionTextView.snp.bottom).offset(100)
            tv.width.equalTo(self.snp.width).multipliedBy(0.9)
            tv.height.equalTo(self.snp.height).multipliedBy(0.15)
        }
    }
    
    private func setUpGuessCorrectLab() {
        timesCorrectLabel.snp.makeConstraints { (lab) in
            lab.centerX.equalTo(self.snp.centerX)
            lab.top.equalTo(answerTextView.snp.bottom).offset(5)
            lab.width.equalTo(self.snp.width).multipliedBy(0.9)
            lab.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
    }

}
