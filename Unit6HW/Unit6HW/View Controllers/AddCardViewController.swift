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

class AddCardViewController: UIViewController {

    let addCardView = AddCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddCardView()

    }

    private func setUpAddCardView() {
        self.view.addSubview(addCardView)
        addCardView.snp.makeConstraints { (acView) in
            acView.size.equalTo(self.view.snp.size)
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
