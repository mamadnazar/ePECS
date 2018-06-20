//
//  FourthLevelCategoryCollectionViewCell.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/7/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class FourthLevelCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    func setCategoryCard(card: Card) {
        categoryNameLabel.text = card.name
        categoryImageView.image = card.image
    }
}
