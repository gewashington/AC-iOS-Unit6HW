//
//  QuizButtonView.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit

class QuizButtonView: UIView {
    lazy var rightButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "rightCheck"), for: .normal)
        return butt
    }()
    
    lazy var wrongButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "wrongX"), for: .normal)
        return butt
    }()
    
    lazy var showAnswerButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Show Answer", for: .normal)
        butt.tintColor = .white
        return butt
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
            backgroundColor = UIColor(red: 92/255, green: 163/255, blue: 230/255, alpha: 1.0)
            setupViews()
        }
        
        private func setupViews() {
            let views = [rightButton, wrongButton, showAnswerButton] as [UIView]
            views.forEach { addSubview($0) }
            setUpRightButton()
            setUpWrongButton()
            setUpShowAnswerButton()
        }
        
    private func setUpRightButton() {
        rightButton.snp.makeConstraints { (butt) in
            butt.left.equalTo(self.snp.left)
            butt.top.equalTo(self.snp.top)
            butt.bottom.equalTo(self.snp.bottom)
            butt.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
    }
    
    private func setUpWrongButton() {
        wrongButton.snp.makeConstraints { (butt) in
            butt.left.equalTo(rightButton.snp.right)
            butt.top.equalTo(self.snp.top)
            butt.bottom.equalTo(self.snp.bottom)
            butt.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
    }
    
    private func setUpShowAnswerButton() {
        showAnswerButton.snp.makeConstraints { (butt) in
            butt.left.equalTo(self.snp.left)
            butt.top.equalTo(self.snp.top)
            butt.bottom.equalTo(self.snp.bottom)
            butt.width.equalTo(self.snp.width)
        }
        
    }
}

