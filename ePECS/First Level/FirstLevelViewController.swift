//
//  FirstLevelViewController.swift
//  ePECS
//
//  Created by ITLabAdmin on 5/25/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

class FirstLevelViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var whiteCardView: UIView! {
        didSet {
            whiteCardView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var wordView: UIView! {
        didSet {
            wordView.layer.borderWidth = 3
            wordView.layer.cornerRadius = 20
            wordView.layer.borderColor = UIColor.init(red: 140, green: 193, blue: 82).cgColor
            //wordView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var wordLabel: UILabel! {
        didSet {
            wordLabel.textColor = UIColor.init(red: 140, green: 193, blue: 82)
        }
    }
    
    @IBOutlet weak var soundImageView: UIImageView!
    //let settingButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .plain, target: self, action: #selector(goToSettings))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        soundImageView.isUserInteractionEnabled = true
        soundImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Этап I"
        navigationItem.hidesBackButton = true
        
    }

    @IBAction func settingsBarButton(_ sender: Any) {
        let sb = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        speakOut(toSpeak: wordLabel.text!)
    }
    
//    @objc func goToSettings() {
//
//    }
    
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
