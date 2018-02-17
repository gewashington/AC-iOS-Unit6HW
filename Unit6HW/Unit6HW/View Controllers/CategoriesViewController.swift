//
//  CategoriesViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/13/18.
//  Copyright © 2018 Glo. All rights reserved.
//
//TODO:
//-Add conditional to deck count string when there is only one deck
import UIKit
import SnapKit
import Firebase



class CategoriesViewController: UIViewController {
    

    
    let categoryView = CategoryView()
    
    private var firebaseAuth = FirebaseAuthorization()
    
    var ref: DatabaseReference!
    
    var decks = [Decks]() {
        didSet{
            categoryView.categoryCollectionView.reloadData()
            categoryView.welcomeLabel.text = "Hi, \(String(describing: Auth.auth().currentUser!.displayName!))! Here are your decks!"
            categoryView.statisticTextView.text = """
            You have \(decks.count.description) decks.
            You have guessed 50% of your cards correctly.
            """
            
        }
    }
    
//    let menuVC = ListOfDecksTableViewController()
    
    
    var currentUser: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        firebaseAuth.delegate = self
        currentUser = Auth.auth().currentUser
        loadCategories()
        //        DatabaseService.shared.deckRef.observe(.value) { (snapshot) in
        //            print(snapshot)
        //        }
        //        DatabaseService.shared.deckRef.observe(.value) { (snapshot) in
        //            print(snapshot)
        //        }
        //        cat2.observe(FIRDataEventType.value, with:
        //            { (snapshot) in
        //                let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
        //
        //
        //
        //                for (_, value) in eventDataloc
        //                {
        //                    let studsmodel = FirebaseStructureCustVM.updateQuestionData(Questiondata: value as![String:Any])
        //
        //                }
        //
        //                print((snapshot))
        //        })
        //        DatabaseService.shared.categoryRef.observe(.value) { (snapshot) in
        //            let eventData = snapshot.value as? [String: AnyObject] ?? [:]
        //            for (_, value) in eventData {
        //                print(value)
        //            }
        //        }
        
        
        view.addSubview(categoryView)
        setUpCatView()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
//        categoryView.welcomeLabel.text = "Hi, \(String(describing: Auth.auth().currentUser!.displayName!))! Here are your decks!"
//        categoryView.statisticTextView.text = """
//        You have \(decks.count.description) decks.
//        You have guessed 50% of your cards correctly.
//        """
        categoryView.logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        categoryView.createDeckButton.addTarget(self, action: #selector(createDeck), for: .touchUpInside)
        categoryView.addCardButton.addTarget(self, action: #selector(addCard), for: .touchUpInside)
        //        categoryView.categoryCollectionView.delegate = self
        categoryView.categoryCollectionView.dataSource = self
    
        
    }
    
    private func setUpCatView() {
        categoryView.snp.makeConstraints { (catView) in
            catView.size.equalTo(self.view.snp.size)
        }
    }
    
    private func loadCategories() {
        DatabaseService.shared.getDecks(from: currentUser) { (onlineCategories) in
            let safeCategories = onlineCategories
            self.decks = safeCategories
            print(self.decks)
            
        }
        
    }
    
    @objc private func logOut() {
        firebaseAuth.signOut()
    }
    
    @objc private func createDeck() {
        let createDeckAC = UIAlertController(title: "Create A New Deck", message: "Enter the name of your new deck here:", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            let textField = createDeckAC.textFields![0] as UITextField
            guard let deckName = textField.text, !deckName.isEmpty else { print("No deckname entered"); return }
            //This saves the deck name to firebase database
            self.ref = Database.database().reference()
            let newDeck = Decks(ref: self.ref, name: deckName)
            if let currentUser = Auth.auth().currentUser {
                let newCat = self.ref.child("users/\(String(describing: currentUser.uid))/categories").childByAutoId()
                newCat.setValue(newDeck.toAnyObject())
                
            }
        }
        createDeckAC.addTextField { (textfield) in
            textfield.placeholder = "Enter deck name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        createDeckAC.addAction(okAction)
        createDeckAC.addAction(cancelAction)
        self.present(createDeckAC, animated: true, completion: nil)
    }
    
    @objc private func addCard() {
        let addCardVC = AddCardViewController(decks: decks)
        self.navigationController?.pushViewController(addCardVC, animated: true)
   }
    
}

extension CategoriesViewController: FirebaseAPIDelegate {
    func didSignout(_ userService: FirebaseAuthorization) {
        let signInVC = UINavigationController(rootViewController: LogInOrCreateAccountViewController())
        present(signInVC, animated: true, completion: nil)
    }
    
    func didFailSigningOut(_ userService: FirebaseAuthorization, error: Error) {
        showAlert(title: "Error Signing Out", message: error.localizedDescription)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okCancel = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okCancel)
        present(alertController, animated: true, completion: nil)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoryCollectionViewCell
        let deck = decks[indexPath.row]
        cell.categoryNameLabel.text = deck.name
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    
}
