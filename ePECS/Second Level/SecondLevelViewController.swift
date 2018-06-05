//
//  SecondLevelViewController.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/26/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

class SecondLevelViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AVSpeechSynthesizerDelegate {
    
    let cards_images = [#imageLiteral(resourceName: "meGirl"), #imageLiteral(resourceName: "хочу"), #imageLiteral(resourceName: "да"), #imageLiteral(resourceName: "нет"), #imageLiteral(resourceName: "мяч"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "кушать"), #imageLiteral(resourceName: "пить"), #imageLiteral(resourceName: "помоги"), #imageLiteral(resourceName: "спать")]
    let cards_names = ["Я", "Хочу", "Да", "Нет", "Мяч", "Машина", "Кушать", "Пить", "Помоги", "Спать"]
    var toSpeak = ""
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet var zoomInView: UIView!
    @IBOutlet weak var zoomInImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissButton(_ sender: Any) {
        hideInformationView()
        dismissButton.isHidden = true
    }
    @IBAction func soundButton(_ sender: Any) {
        speakOut(toSpeak: toSpeak)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.isHidden = true
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
    
    private func hideInformationView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.zoomInView.alpha = 0
            self.zoomInView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY)
        }) { (success) in
            self.zoomInView.removeFromSuperview()
        }
    }
    
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondLevelCollectionViewCell", for: indexPath) as! SecondLevelCollectionViewCell
        
        cell.cardImageView.image = cards_images[indexPath.row]
        cell.cardNameLabel.text = cards_names[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toSpeak = cards_names[indexPath.row]
        setupZoomInView(image: cards_images[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/2.1, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
