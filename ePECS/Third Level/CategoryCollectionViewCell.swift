//
//  CategoryCollectionViewCell.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/28/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    //var card: Card!
    
    func setCategoryCard(card: Card) {
        categoryNameLabel.text = card.name
        categoryImageView.image = card.image
    }
    
}
