//
//  ListOfDecksTableViewController.swift
//  Unit6HW
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 Glo. All rights reserved.
//

import UIKit


class ListOfDecksTableViewController: UITableViewController {
    
    var delegate: ChosenDeck?
    var currentDeckName: String?
    
    var decks = [Decks]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    init(decks: [Decks]) {
        super.init(nibName: nil, bundle: nil)
        self.decks = decks
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeckCell")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = self.delegate {
            delegate.didChooseDeck(deck: currentDeckName ?? "Choose A Deck")
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return decks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeckCell", for: indexPath)
        let deck = decks[indexPath.row]
        cell.textLabel?.text = deck.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deck = decks[indexPath.row]
        currentDeckName = deck.name
        self.navigationController?.popViewController(animated: true)
       
   
    }
}

