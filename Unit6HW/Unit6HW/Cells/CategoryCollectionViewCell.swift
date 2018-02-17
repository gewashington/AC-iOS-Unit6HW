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
    
    
    
//    lazy var mainBackground: UIView = {
//        let view = UIView()
//        return view
//    }()
//    lazy var shadowLayer: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    lazy var categoryNameLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Category"
        lab.textColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
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
        setupViews()
    }
    
    private func setupViews() {
        addSubview(categoryNameLabel)
//                addSubview(mainBackground)
//                addSubview(shadowLayer)
        categoryNameLabel.snp.makeConstraints { (lab) in
            lab.width.equalTo(self.snp.width).multipliedBy(0.8)
            lab.height.equalTo(self.snp.height).multipliedBy(0.7)
            lab.centerX.equalTo(self.snp.centerX)
            lab.centerY.equalTo(self.snp.centerY)
        }
//        customizeCell()
        
    }
    
//    private func customizeCell() {
//        //adds shadow to cells
//        mainBackground.snp.makeConstraints { (view) in
//            view.size.equalTo(self.snp.size)
//        }
//        shadowLayer.snp.makeConstraints { (view) in
//            view.size.equalTo(self.snp.size)
//        }
//
//        mainBackground.layer.backgroundColor = UIColor.white.cgColor
//        mainBackground.layer.cornerRadius = 8
//        mainBackground.layer.masksToBounds = true
//        shadowLayer.layer.backgroundColor = UIColor.white.cgColor
//        shadowLayer.layer.masksToBounds = false
//        shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 0)
//        shadowLayer.layer.shadowColor = UIColor.black.cgColor
//        shadowLayer.layer.shadowOpacity = 0.23
//        shadowLayer.layer.shadowRadius = 4
//        shadowLayer.layer.shadowPath = UIBezierPath(rect: shadowLayer.bounds).cgPath
//        shadowLayer.layer.shouldRasterize = true
//    }
    
    
    public func configureCell() {
        
    }
}
