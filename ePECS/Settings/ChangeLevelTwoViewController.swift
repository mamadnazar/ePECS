//
//  ChangeLevelTwoViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class ChangeLevelTwoViewController: UIViewController {
    
    class var shared: ChangeLevelTwoViewController {
        struct Static {
            static let instance = ChangeLevelTwoViewController()
        }
        return Static.instance
    }
    
    private var cards_images = [#imageLiteral(resourceName: "meGirl"), #imageLiteral(resourceName: "хочу"), #imageLiteral(resourceName: "да"), #imageLiteral(resourceName: "нет"), #imageLiteral(resourceName: "мяч"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "кушать"), #imageLiteral(resourceName: "пить"), #imageLiteral(resourceName: "помоги"), #imageLiteral(resourceName: "спать")]
    private var cards_names = ["Я", "Хочу", "Да", "Нет", "Мяч", "Машина", "Кушать", "Пить", "Помоги", "Спать"]
    private var cards: [Card] = []
    
    var selectedCard: Int?
    var cellCardCount = 0
    
    @IBOutlet weak var changeLevelTwoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCards()
    }
    
    private func setupCards() {
        var card: Card?
        var index: Int?
        for i in cards_names {
            index = cards_names.index(of: i)
            card = Card(index: index!, name: cards_names[index!], image: cards_images[index!])
            cards.append(card!)
        }
    }
       
    func getCardsImages() -> [UIImage] {
        return cards_images
    }
    
    func getCardsNames() -> [String] {
        return cards_names
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChangeLevelTwoViewController: ChangeLevelTwoCollectionViewCellDelegate {
    func didTapDelete(cardToDelete: Card) {
        cards.remove(at: cards.index(of: cardToDelete)!)
        changeLevelTwoCollectionView.reloadData()
    }
    
}

extension ChangeLevelTwoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChangeLevelTwoCollectionViewCell", for: indexPath) as! ChangeLevelTwoCollectionViewCell
        cell.setPhraseCard(card: cards[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = changeLevelTwoCollectionView.frame.size.width / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

