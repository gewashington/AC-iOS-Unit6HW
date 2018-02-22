//
//  CategoryCollectionViewCell.swift
//  Unit6HW
//
//  Created by C4Q on 2/13/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {

    
    lazy var categoryNameLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Category"
        lab.textColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        lab.textAlignment = .center
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
        backgroundColor = .white
         self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        setupViews()
    }
    
    private func setupViews() {
        addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { (lab) in
            lab.width.equalTo(self.snp.width).multipliedBy(0.8)
            lab.height.equalTo(self.snp.height).multipliedBy(0.7)
            lab.centerX.equalTo(self.snp.centerX)
            lab.centerY.equalTo(self.snp.centerY)
        }
        
    }
    

}
