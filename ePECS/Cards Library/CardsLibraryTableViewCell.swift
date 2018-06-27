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

class CardsLibraryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var cards: [Card] = []
    var categoryIndex: Int?
    @IBOutlet weak var cardsLibraryCollectionView: UICollectionView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    var cardsLibraryCollectionViewCellDelegate: CardsLibraryCollectionViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardsLibraryCollectionView.dataSource = self
        self.cardsLibraryCollectionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }

    @objc func loadList(notification: NSNotification) {
        self.cardsLibraryCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsLibraryCollectionViewCell", for: indexPath) as! CardsLibraryCollectionViewCell
        cell.setCard(card: cards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (cards[indexPath.row].index == 99) {
            cardsLibraryCollectionViewCellDelegate.collectionViewCellDidTapToAdd(categoryIndex: categoryIndex!)
        }
        else {
            cardsLibraryCollectionViewCellDelegate.collectionViewCellDidTap(card: cards[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
