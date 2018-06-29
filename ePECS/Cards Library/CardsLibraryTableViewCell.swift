//
//  CardsLibraryTableViewCell.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/22/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

protocol CardsLibraryCollectionViewCellDelegate: class {
    func collectionViewCellDidTap(card: Card)
    func collectionViewCellDidTapToAdd()
}

class CardsLibraryTableViewCell: UITableViewCell {

    var cards: [Card] = []
    var categoryIndex: Int?
    @IBOutlet weak var cardsLibraryCollectionView: UICollectionView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        cardsLibraryCollectionView.delegate = dataSourceDelegate
        cardsLibraryCollectionView.dataSource = dataSourceDelegate
        cardsLibraryCollectionView.tag = row
        cardsLibraryCollectionView.reloadData()
    }
}
