//
//  FourthLevelPhraseCollectionViewCell.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/7/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

protocol FourthLevelPhraseCollectionViewCellDelegate {
    
    func didTapDelete(cardToDelete: Card)
}

class FourthLevelPhraseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var phraseImageView: UIImageView!
    
    var card: Card!
    var delegate: FourthLevelPhraseCollectionViewCellDelegate?
    
    func setPhraseCard(card: Card) {
        self.card = card
        phraseImageView.image = card.image
    }
    
    @IBAction func deleteCardTapped(_ sender: Any) {
        delegate?.didTapDelete(cardToDelete: card)
    }
    
}
