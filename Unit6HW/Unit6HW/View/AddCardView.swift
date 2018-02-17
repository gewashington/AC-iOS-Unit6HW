//
//  AddCardView.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit

class AddCardView: UIView {
    
    lazy var menuButton: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .purple
        return butt
    }()
    
    lazy var questionLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Front"
        lab.textColor = .black
        return lab
    }()
    
    lazy var questionTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .green
        return tf
    }()
    
    lazy var answerLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Back"
        lab.textColor = .black
        return lab
    }()
    
    
    lazy var answerTextField: UITextField  = {
        let tf = UITextField()
        tf.backgroundColor = .green
        return tf
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        let views = [menuButton, questionLabel, questionTextField, answerLabel, answerTextField] as [UIView]
        views.forEach { addSubview($0)}
        setUpCategoryButton()
        setUpQuestionLab()
        setUpQuestionTF()
        setUpAnswerLab()
        setUpAnswerTF()
    }
    
    private func setUpCategoryButton() {
        menuButton.snp.makeConstraints { (butt) in
            butt.centerX.equalTo(self.snp.centerX)
            butt.top.equalTo(self.snp.top).offset(70)
            butt.width.equalTo(self.snp.width).multipliedBy(0.8)
            butt.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
    }
    
    private func setUpQuestionLab() {
        questionLabel.snp.makeConstraints { (lab) in
            lab.top.equalTo(menuButton.snp.bottom).offset(30)
            lab.left.equalTo(self.snp.left).offset(40)
            lab.height.equalTo(self.snp.height).multipliedBy(0.1)
            lab.width.equalTo(self.snp.width).multipliedBy(0.2)

        }
    }
    
    private func setUpQuestionTF() {
        questionTextField.snp.makeConstraints { (tf) in
            tf.top.equalTo(questionLabel.snp.bottom).offset(5)
            tf.left.equalTo(questionLabel.snp.left).offset(10)
            tf.height.equalTo(self.snp.height).multipliedBy(0.1)
            tf.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
    }
    
    private func setUpAnswerLab() {
        answerLabel.snp.makeConstraints { (lab) in
            lab.top.equalTo(questionTextField.snp.bottom).offset(15)
            lab.left.equalTo(questionLabel.snp.left)
            lab.height.equalTo(self.snp.height).multipliedBy(0.1)
            lab.width.equalTo(self.snp.width).multipliedBy(0.2)
        }
    }
    
    private func setUpAnswerTF() {
        answerTextField.snp.makeConstraints { (tf) in
            tf.top.equalTo(answerLabel.snp.bottom).offset(5)
            tf.left.equalTo(questionTextField.snp.left)
            tf.height.equalTo(self.snp.height).multipliedBy(0.1)
            tf.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
    }
    
    
}