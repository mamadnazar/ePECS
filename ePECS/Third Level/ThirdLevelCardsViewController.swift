//
//  ThirdLevelCardsViewController.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/28/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

var phrase_cards: [Card] = [Card(index: 1, name: "Я", image: #imageLiteral(resourceName: "meGirl")), Card(index: 2, name: "Хочу", image: #imageLiteral(resourceName: "хочу"))]
var phraseToSpeak = ""

class ThirdLevelCardsViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    //private var phrasesToSpeak = ThirdLevelCategoryViewController.shared.phrasesToSpeak
    //private var phrase_cards = ThirdLevelCategoryViewController.shared.phrase_cards
    
    var categoryId = 0
    var navTitle = ""
    var selectedCard = 0
    var toSpeak = ""
    private var cards: [Card] = []
    
    @IBOutlet var zoomInView: UIView!
    @IBOutlet weak var upperZoomInView: UIView! {
        didSet {
            upperZoomInView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var downZoomInView: UIView! {
        didSet {
            downZoomInView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    @IBOutlet weak var playAllButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var zoomInImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        dismissButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupCardsArray()
        cardsCollectionView.reloadData()
        phraseCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupCardsArray() {
        let card1 = Card(index: 11, name: "Компьютер", image: #imageLiteral(resourceName: "компьютер"))
        let card2 = Card(index: 9, name: "Помоги", image: #imageLiteral(resourceName: "помоги"))
        let card3 = Card(index: 8, name: "Пить", image: #imageLiteral(resourceName: "пить"))
        let card4 = Card(index: 7, name: "Кушать", image: #imageLiteral(resourceName: "кушать"))
        
        cards.append(card1)
        cards.append(card2)
        cards.append(card3)
        cards.append(card4)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        hideZoomInView()
        dismissButton.isHidden = true
    }
    
    @IBAction func playAllButton(_ sender: Any) {
        
        phraseToSpeak = ""
        for i in phrase_cards {
            phraseToSpeak += "\(i.name)"
        }
        speakOut(toSpeak: phraseToSpeak)
    }
    
    @IBAction func playButton(_ sender: Any) {
        speakOut(toSpeak: toSpeak)
    }
    
    @IBAction func addButton(_ sender: Any) {
        addToPhrase(index: selectedCard)
    }
    
    private func setupZoomInView(image: UIImage) {
        view.addSubview(zoomInView)
        
        zoomInImageView.image = image
        
        zoomInView.center = CGPoint(x: view.frame.midX, y: view.frame.minY)
        zoomInView.alpha = 0
        dismissButton.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.zoomInView.alpha = 1
            self.zoomInView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height / 2 - 35)
        }
    }
    
    private func hideZoomInView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.zoomInView.alpha = 0
            self.zoomInView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY)
        }) { (success) in
            self.zoomInView.removeFromSuperview()
        }
    }
    
    private func addToPhrase(index: Int) {
        let phraseCard = Card(index: cards[index].index, name: cards[index].name, image: cards[index].image)
        phrase_cards.append(phraseCard)
        phraseCollectionView.reloadData()
        
        hideZoomInView()
        dismissButton.isHidden = true
    }
    
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }
    
}

extension ThirdLevelCardsViewController: PhraseCollectionViewCellDelegate {
    
    func didTapDelete(cardToDelete: Card) {
        
        let index = phrase_cards.index(of: cardToDelete)
        if (index != 0 && index != 1) {
            phrase_cards.remove(at: index!)
        }
        phraseCollectionView.reloadData()
    }
}

extension ThirdLevelCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return phrase_cards.count
        }
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhraseCollectionViewCell", for: indexPath) as! PhraseCollectionViewCell
            cell.setPhraseCard(card: phrase_cards[indexPath.row])
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCollectionViewCell", for: indexPath) as! CardCollectionViewCell
            cell.setCard(card: cards[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cardsCollectionView {
            selectedCard = indexPath.row
            toSpeak = cards[indexPath.row].name
            setupZoomInView(image: cards[indexPath.row].image)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = cardsCollectionView.frame.size.height / 2
        let phrase_width = phraseCollectionView.frame.size.height / 1.4
        
        if collectionView == phraseCollectionView {
            return CGSize(width: phrase_width, height: phrase_width)
        }
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
