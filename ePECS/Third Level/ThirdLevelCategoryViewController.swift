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
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    var categories_names = ["Transport", "Eating", "Drinking", "Helping", "Technology"]
    var categories_images = [#imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "кушать"), #imageLiteral(resourceName: "пить"), #imageLiteral(resourceName: "помоги"), #imageLiteral(resourceName: "компьютер")]
    
    @IBOutlet weak var playAllButton: UIButton! {
        didSet {
            playAllButton.layer.cornerRadius = 20
            playAllButton.layer.borderWidth = 1
            playAllButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBAction func playAllButton(_ sender: Any) {
       
        phrasesToSpeak = ""
        for i in phrases_names {
            phrasesToSpeak += "\(i)"
        }
        speakOut(toSpeak: phrasesToSpeak)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        phraseCollectionView.reloadData()
        categoryCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }

}

extension ThirdLevelCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return phrases_names.count
        }
        return categories_names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhraseCollectionViewCell", for: indexPath) as! PhraseCollectionViewCell 
            cell.phraseImageView.image = phrases_images[indexPath.row]
            cell.phraseLabel.text = phrases_names[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.categoryNameLabel.text = categories_names[indexPath.row]
            cell.categoryImageView.image = categories_images[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let vc = UIStoryboard(name: "ThirdLevelStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ThirdLevelCardsViewController") as! ThirdLevelCardsViewController
            vc.categoryId = categories_names.index(of: categories_names[indexPath.row])!
            vc.navTitle = categories_names[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        } else {
            if (indexPath.row != 0 && indexPath.row != 1) {
                phrases_names.remove(at: indexPath.row)
                phrases_images.remove(at: indexPath.row)
            }
            phraseCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width / 2.2 - 16

        if collectionView == phraseCollectionView {
            return CGSize(width: 130, height: 120)
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
