//
//  SecondLevelCollectionViewCell.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/27/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class SecondLevelCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardView: CustomView! {
        didSet {
            self.cardView.layer.cornerRadius = 10
        }
    }
    
    func setCard(card: Card) {
        cardImageView.image = card.image
    }
}
