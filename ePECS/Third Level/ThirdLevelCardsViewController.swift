//
//  ThirdLevelCardsViewController.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/28/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

var phrases_names: [String] = ["я", "хочу"]
var phrases_images: [UIImage] = [#imageLiteral(resourceName: "meGirl"), #imageLiteral(resourceName: "хочу")]
var phrasesToSpeak = ""

class ThirdLevelCardsViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    var categoryId = 0
    var navTitle = ""
    var selectedCard = 0
    var toSpeak = ""
    
    var cards_names = ["машина", "кушать", "пить", "помоги", "компьютер"]
    var cards_images = [#imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "кушать"), #imageLiteral(resourceName: "пить"), #imageLiteral(resourceName: "помоги"), #imageLiteral(resourceName: "компьютер")]
    
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
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    @IBOutlet weak var playAllButton: UIButton! {
        didSet {
            playAllButton.layer.cornerRadius = 20
            playAllButton.layer.borderWidth = 1
            playAllButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var zoomInImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navTitle
        dismissButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        categoryCollectionView.reloadData()
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
        
        phrasesToSpeak = ""
        for i in phrases_names {
            phrasesToSpeak += "\(i)"
        }
        speakOut(toSpeak: phrasesToSpeak)
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
        let name = cards_names[index]
        let image = cards_images[index]
        phrases_names.append(name)
        phrases_images.append(image)
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

extension ThirdLevelCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return phrases_names.count
        }
        return cards_names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhraseCollectionViewCell", for: indexPath) as! PhraseCollectionViewCell
            cell.phraseImageView.image = phrases_images[indexPath.row]
            cell.phraseLabel.text = phrases_names[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCollectionViewCell", for: indexPath) as! CardCollectionViewCell
            cell.cardImageView.image = cards_images[indexPath.row]
            cell.cardLabel.text = cards_names[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == phraseCollectionView {
            if (indexPath.row != 0 && indexPath.row != 1) {
                phrases_names.remove(at: indexPath.row)
                phrases_images.remove(at: indexPath.row)
            }
            phraseCollectionView.reloadData()
        } else {
            selectedCard = indexPath.row
            toSpeak = cards_names[indexPath.row]
            setupZoomInView(image: cards_images[indexPath.row])
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
