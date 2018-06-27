//
//  PhraseCollectionViewCell.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/28/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

protocol PhraseCollectionViewCellDelegate {
    
    func didTapDelete(cardToDelete: Card)
}

class PhraseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var phraseImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var card: Card!
    var delegate: PhraseCollectionViewCellDelegate?
    
    func setPhraseCard(card: Card) {
        self.card = card
        phraseImageView.image = card.image
    }
    
    @IBAction func deleteCardTapped(_ sender: Any) {
        delegate?.didTapDelete(cardToDelete: card)
    }
}
