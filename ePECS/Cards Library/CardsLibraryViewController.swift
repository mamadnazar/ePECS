//
//  CardsLibraryViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class CardsLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var allCards: [String : Array<Card>] = [:]
    @IBOutlet weak var cardsLibraryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardsLibraryTableView.estimatedRowHeight = 120
        cardsLibraryTableView.tableFooterView = UIView()
        cardsLibraryTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        allCards = DataManager.shared.getCategories()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return allCards.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsLibraryTableViewCell") as! CardsLibraryTableViewCell
        cell.categoryNameLabel.text = Array(allCards.keys)[indexPath.section]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
