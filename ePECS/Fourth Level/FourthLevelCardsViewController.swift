//
//  FourthLevelCardsViewController.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/7/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

var fourthLevel_phrases_cards: [Card] = []
var fourthLevel_phrasesToSpeak = ""

class FourthLevelCardsViewController: UIViewController, AVSpeechSynthesizerDelegate {

    private var allCards: [String : Array<Card>] = [:]
    var categoryId = 0
    var navTitle = ""
    private var selectedCard = 0
    var toSpeak = ""
    
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
        
        allCards = DataManager.shared.getCategories()
        cardsCollectionView.reloadData()
        phraseCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        hideZoomInView()
        dismissButton.isHidden = true
    }
    
    @IBAction func playAllButton(_ sender: Any) {
        
        fourthLevel_phrasesToSpeak = ""
        for i in fourthLevel_phrases_cards {
            fourthLevel_phrasesToSpeak += " "
            fourthLevel_phrasesToSpeak += i.name
        }
        speakOut(toSpeak: fourthLevel_phrasesToSpeak)
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
        let phraseCard = Card(index: allCards[navTitle]![index].index, name: allCards[navTitle]![index].name, image: allCards[navTitle]![index].image)
        fourthLevel_phrases_cards.append(phraseCard)
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

extension FourthLevelCardsViewController: FourthLevelPhraseCollectionViewCellDelegate {
    
    func didTapDelete(cardToDelete: Card) {
        
        let index = fourthLevel_phrases_cards.index(of: cardToDelete)
        fourthLevel_phrases_cards.remove(at: index!)
        phraseCollectionView.reloadData()
    }
}

extension FourthLevelCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return fourthLevel_phrases_cards.count
        }
        return (allCards[navTitle]?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthLevelPhraseCollectionViewCell", for: indexPath) as! FourthLevelPhraseCollectionViewCell
            cell.setPhraseCard(card: fourthLevel_phrases_cards[indexPath.row])
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthLevelCardsCollectionViewCell", for: indexPath) as! FourthLevelCardCollectionViewCell
            cell.setCard(card: allCards[navTitle]![indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == cardsCollectionView {
            selectedCard = indexPath.row
            toSpeak = allCards[navTitle]![indexPath.row].name
            setupZoomInView(image: allCards[navTitle]![indexPath.row].image)
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
