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
    
    let cards_images = ChangeLevelTwoViewController.shared.getCardsImages()
    let cards_names = ChangeLevelTwoViewController.shared.getCardsNames()
    var toSpeak = ""
    
    @IBOutlet weak var zoomInUpperView: UIView! {
        didSet {
            self.zoomInUpperView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var zoomInDownView: UIView! {
        didSet {
            self.zoomInDownView.layer.cornerRadius = 20
        }
    }
    @IBOutlet var zoomInView: UIView!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var zoomInImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissButton(_ sender: Any) {
        hideZoomInView()
        dismissButton.isHidden = true
    }
    @IBAction func soundButton(_ sender: Any) {
        speakOut(toSpeak: toSpeak)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.isHidden = true
        
        setupSettingsButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Этап II"
        navigationItem.hidesBackButton = true
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
    
    
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards_names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondLevelCollectionViewCell", for: indexPath) as! SecondLevelCollectionViewCell
        
        cell.cardImageView.image = cards_images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toSpeak = cards_names[indexPath.row]
        setupZoomInView(image: cards_images[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2
        return CGSize(width: width, height: width)
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
