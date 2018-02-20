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
    
    var currentUser: User!
    
    var ref: DatabaseReference!
    
    var decks = [Decks]() {
        didSet{
            categoryView.categoryCollectionView.reloadData()
            categoryView.welcomeLabel.text = "Hi, \(String(describing: Auth.auth().currentUser!.displayName!))! Here are your decks!"
            categoryView.statisticTextView.text = """
            You have \(decks.count.description) decks.
            """
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        firebaseAuth.delegate = self
        currentUser = Auth.auth().currentUser
        loadCategories()
        //        DatabaseService.shared.deckRef.observe(.value) { (snapshot) in
        //            print(snapshot)
        //        }
        
        view.addSubview(categoryView)
        setUpCatView()
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 51/255, green: 156/255, blue: 255/255, alpha: 1.0)
        navBar?.tintColor = .white
        navBar?.isTranslucent = false
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        categoryView.logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        categoryView.createDeckButton.addTarget(self, action: #selector(createDeck), for: .touchUpInside)
        categoryView.addCardButton.addTarget(self, action: #selector(addCard), for: .touchUpInside)
        categoryView.categoryCollectionView.dataSource = self
        categoryView.categoryCollectionView.delegate = self
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
        let createDeckAC = UIAlertController(title: "Create A New Deck", message: "Enter the name of your new deck.", preferredStyle: .alert)
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
        if !decks.isEmpty {
            print(decks)
            let addCardVC = AddCardViewController(decks: decks)
            self.navigationController!.pushViewController(addCardVC, animated: true)
        }
        else {
            showAlert(title: "No Decks", message: "You need to create a deck to create cards. Please do that first!")
        } 
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


//Set Up VC Collection View
extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoryCollectionViewCell
        let deck = decks[indexPath.row]
        cell.categoryNameLabel.text = deck.name
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let deck = decks[indexPath.row]
        self.ref = Database.database().reference()
        
        self.ref.child("users/\(currentUser.uid)/cards").observeSingleEvent(of: (.value)) { (snapshot) in
            if snapshot.hasChild(deck.name) {
                let quizVC = QuizWithCardsViewController(deckTitle: deck.name)
                self.navigationController?.pushViewController(quizVC, animated: true)
            }
            else {
                self.showAlert(title: "Empty Deck", message: "Can't have a deck without cards! Please add a card or two to this deck.")
            }
        }
        
    }
    
}

