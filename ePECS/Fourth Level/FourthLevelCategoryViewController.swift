//
//  FourthLevelCategoryViewController.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/7/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

class FourthLevelCategoryViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    private var allCards2 = [Categories]()
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    
    @IBOutlet weak var playAllButton: UIButton!
    @IBAction func playAllButton(_ sender: Any) {
        
        fourthLevel_phrasesToSpeak = ""
        for i in fourthLevel_phrases_cards {
            fourthLevel_phrasesToSpeak += " "
            fourthLevel_phrasesToSpeak += i.name
        }
        speakOut(toSpeak: fourthLevel_phrasesToSpeak)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "Этап IV"
        navigationItem.hidesBackButton = true
        setupSettingsButton()
        
        allCards2 = DataManager.shared.loadAllCards()
        for i in allCards2 {
            i.cards.remove(at: i.cards.count-1)
        }
        phraseCollectionView.reloadData()
    }
    
    private func setupSettingsButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "settings"), for: UIControlState.normal)
        button.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 26).isActive = true
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.addTarget(self, action: #selector(settingsButtonPressed), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func settingsButtonPressed() {
        let sb = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension FourthLevelCategoryViewController: FourthLevelPhraseCollectionViewCellDelegate {
    
    func didTapDelete(cardToDelete: Card) {
        let index = fourthLevel_phrases_cards.index(of: cardToDelete)
        fourthLevel_phrases_cards.remove(at: index!)
        phraseCollectionView.reloadData()
    }
}

extension FourthLevelCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return fourthLevel_phrases_cards.count
        }
        return allCards2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthLevelPhraseCollectionViewCell", for: indexPath) as! FourthLevelPhraseCollectionViewCell
            cell.setPhraseCard(card: fourthLevel_phrases_cards[indexPath.row])
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FourthLevelCategoryCollectionViewCell", for: indexPath) as! FourthLevelCategoryCollectionViewCell
            let category = allCards2[indexPath.row].categoryName
            cell.categoryNameLabel.text = category
            if allCards2[indexPath.row].cards.count == 0 {
                return cell
            }
            cell.categoryImageView.image = allCards2[indexPath.row].cards[0].image
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FourthLevelCardsViewController") as! FourthLevelCardsViewController
            vc.categoryId = indexPath.row
            vc.navTitle = allCards2[indexPath.row].categoryName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = categoryCollectionView.frame.size.height / 2
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
