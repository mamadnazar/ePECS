//
//  ThirdLevelViewController.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/28/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdLevelCategoryViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    class var shared: ThirdLevelCategoryViewController {
        struct Static {
            static let instance = ThirdLevelCategoryViewController()
        }
        return Static.instance
    }
    
    var categories_cards: [Card] = []
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    
    @IBOutlet weak var playAllButton: UIButton!
    @IBAction func playAllButton(_ sender: Any) {
       
        phraseToSpeak = ""
        for i in phrase_cards {
            phraseToSpeak += "\(i.name)"
        }
        speakOut(toSpeak: phraseToSpeak)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "Этап III"
        navigationItem.hidesBackButton = true
        setupSettingsButton()
        
        setupCategoriesCardsArray()
        categoryCollectionView.reloadData()
        phraseCollectionView.reloadData()
    }

    private func setupCategoriesCardsArray() {
    
        let card1 = Card(index: 0, name: "Transport", image: #imageLiteral(resourceName: "car"))
        let card2 = Card(index: 1, name: "Eating", image: #imageLiteral(resourceName: "кушать"))
        let card3 = Card(index: 2, name: "Drinking", image: #imageLiteral(resourceName: "пить"))
        let card4 = Card(index: 3, name: "Helping", image: #imageLiteral(resourceName: "помоги"))
        let card5 = Card(index: 4, name: "Technology", image: #imageLiteral(resourceName: "компьютер"))

        categories_cards.append(card1)
        categories_cards.append(card2)
        categories_cards.append(card3)
        categories_cards.append(card4)
        categories_cards.append(card5)
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

extension ThirdLevelCategoryViewController: PhraseCollectionViewCellDelegate {
    
    func didTapDelete(cardToDelete: Card) {
        
        let index = phrase_cards.index(of: cardToDelete)
        if (index != 0 && index != 1) {
            phrase_cards.remove(at: index!)
        }
        phraseCollectionView.reloadData()
    }
    
}

extension ThirdLevelCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return phrase_cards.count
        }
        return categories_cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhraseCollectionViewCell", for: indexPath) as! PhraseCollectionViewCell
            cell.setPhraseCard(card: phrase_cards[indexPath.row])
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setCategoryCard(card: categories_cards[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let vc = UIStoryboard(name: "ThirdLevelStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ThirdLevelCardsViewController") as! ThirdLevelCardsViewController
            vc.navTitle = categories_cards[indexPath.row].name
            navigationController?.pushViewController(vc, animated: true)
        }
//        else {
//            if (indexPath.row != 0 && indexPath.row != 1) {
//                phrases_names.remove(at: indexPath.row)
//                phrases_images.remove(at: indexPath.row)
//            }
//            phraseCollectionView.reloadData()
//        }
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
