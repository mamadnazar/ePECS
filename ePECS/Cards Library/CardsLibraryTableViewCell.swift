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
    func collectionViewCellDidTapToAdd(categoryIndex: Int)
}

class CardsLibraryTableViewCell: UITableViewCell {

    var cards: [Card] = []
    var categoryIndex: Int?
    var cardsLibraryCollectionViewCellDelegate: CardsLibraryCollectionViewCellDelegate?
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (cards[indexPath.row].index == 99) {
            cardsLibraryCollectionViewCellDelegate?.collectionViewCellDidTapToAdd(categoryIndex: categoryIndex!)
        }
        else {
            cardsLibraryCollectionViewCellDelegate?.collectionViewCellDidTap(card: cards[indexPath.row])
        }
    }
    
}
