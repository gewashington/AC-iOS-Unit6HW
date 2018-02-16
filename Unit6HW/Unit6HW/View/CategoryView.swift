//
//  CategoryView.swift
//  Unit6HW
//
//  Created by C4Q on 2/13/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit

/*TODO:
 - Fix title label constraints */

class CategoryView: UIView {
    
    lazy var welcomeLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Hi Glo! Here are your cards!"
        lab.adjustsFontSizeToFitWidth = true
        lab.textColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        //        lab.backgroundColor = .black
        lab.textAlignment = .center
        lab.font = UIFont(name: "Gill Sans", size: 25)
        return lab
    }()
    
    lazy var statisticTextView: UITextView = {
        let txt = UITextView()
        txt.text = """
        You have 0 cards.
        You guessed 50% of your decks correctly!
        """
        txt.textColor = .black
        txt.font = UIFont(name: "Gill Sans", size: 12)
        txt.textAlignment = .center
        return txt
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        let numberOfCells: CGFloat = 5.0
        layout.itemSize = CGSize(width: (screenWidth * 0.8) - (cellSpacing * 2) , height:  (screenHeight / numberOfCells) - (cellSpacing * numberOfCells) + 1) //sizes the cell
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing) //Makes spacing between cells
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCell")
        cv.backgroundColor = .white
        let defaultCell = CategoryCollectionViewCell()
        return cv
    }()
    
    lazy var addCardButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "addCard"), for: .normal)
        return butt
    }()
    
    lazy var createDeckButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "createDeck"), for: .normal)
        return butt
    }()
    
    lazy var logoutButton: UIButton = {
        let butt = UIButton()
        butt.setImage(#imageLiteral(resourceName: "logOut"), for: .normal)
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        let views = [welcomeLabel, statisticTextView, categoryCollectionView, addCardButton, createDeckButton, logoutButton] as [UIView]
        views.forEach { addSubview($0) }
        setUpWelcomeLabel()
        setUpStatLabel()
        setUpCollectView()
        setUpAddCardButton()
        setUpCreateButton()
        setUpLogoutButton()
    }
    
    private func setUpWelcomeLabel() {
        
        welcomeLabel.snp.makeConstraints { (lab) in
            lab.height.equalTo(self.snp.height).multipliedBy(0.1)
            lab.width.equalTo(self.snp.width).multipliedBy(0.8)
            lab.centerX.equalTo(self.snp.centerX)
            lab.top.equalTo(self.snp.top).offset(60)
        }
    }
    
    private func setUpStatLabel() {
        statisticTextView.snp.makeConstraints {  (txt) in
            txt.height.equalTo(self.snp.height).multipliedBy(0.1)
            txt.width.equalTo(self.snp.width).multipliedBy(0.7)
            txt.top.equalTo(welcomeLabel.snp.bottom).offset(5)
            txt.centerX.equalTo(welcomeLabel.snp.centerX)
        }
    }
    
    private func setUpCollectView() {
        categoryCollectionView.snp.makeConstraints { (cv) in
            cv.top.equalTo(statisticTextView.snp.bottom).offset(5)
            cv.width.equalTo(self.snp.width).multipliedBy(0.9)
//            cv.height.equalTo(self.snp.height).multipliedBy(0.6)
            cv.bottom.equalTo(addCardButton.snp.top)
            cv.centerX.equalTo(welcomeLabel.snp.centerX)

        }
    }
    
    private func setUpAddCardButton() {
        addCardButton.snp.makeConstraints { (butt) in
            butt.bottom.equalTo(self.snp.bottom)
            butt.width.equalTo(self.snp.width).multipliedBy(0.33)
            butt.height.equalTo(self.snp.height).multipliedBy(0.1)
            butt.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setUpCreateButton() {
        createDeckButton.snp.makeConstraints { (butt) in
            butt.bottom.equalTo(self.snp.bottom)
            butt.width.equalTo(self.snp.width).multipliedBy(0.33)
            butt.height.equalTo(self.snp.height).multipliedBy(0.1)
            butt.right.equalTo(addCardButton.snp.left)
        }
    }
    
    private func setUpLogoutButton() {
        logoutButton.snp.makeConstraints { (butt) in
            butt.bottom.equalTo(self.snp.bottom)
            butt.width.equalTo(self.snp.width).multipliedBy(0.33)
            butt.height.equalTo(self.snp.height).multipliedBy(0.1)
            butt.left.equalTo(addCardButton.snp.right)
        }
    }
    
}
