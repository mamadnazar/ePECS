//
//  CardsLibraryCollectionViewCell.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/22/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class CardsLibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardsLibraryCustomView: UIView! {
        didSet {
            cardsLibraryCustomView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var cardsLibraryImage: UIImageView!
    
    func setCard(card: Card) {
        cardsLibraryImage.image = card.image
    }
    
}
