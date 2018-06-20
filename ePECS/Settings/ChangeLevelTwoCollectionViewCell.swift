//
//  ChangeLevelTwoCollectionViewCell.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

protocol ChangeLevelTwoCollectionViewCellDelegate {
    
     func didTapDelete(cardToDelete: Card)
}

class ChangeLevelTwoCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var changeLevelTwoCustomView: CustomView! {
        didSet {
            self.changeLevelTwoCustomView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var changeLevelTwoImageView: UIImageView!
    var card: Card!
    var delegate: ChangeLevelTwoCollectionViewCellDelegate?
    
    func setPhraseCard(card: Card) {
        self.card = card
        changeLevelTwoImageView.image = card.image
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.didTapDelete(cardToDelete: card)
    }
}
