//
//  SettingsViewController.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/9/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var setupLevels: UIButton! {
        didSet {
            self.setupLevels.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var aboutApp: UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "wasLaunched")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Главное"
        navigationItem.hidesBackButton = true
    }
        
    @IBAction func setupLevels(_ sender: Any) {
        //setupLevels.isHighlighted = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectLevelViewController") as! SelectLevelViewController
        self.navigationController?.show(vc, sender: self)
    }

    @IBAction func levelOne(_ sender: Any) {
        let sb = UIStoryboard(name: "FirstLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FirstLevelViewController") as! FirstLevelViewController
        self.navigationController?.show(vc, sender: self)
    }
    @IBAction func longPressOnLevelOne(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            showAlert(level: 1)
        }
    }
    
    
    @IBAction func levelTwo(_ sender: Any) {
        let sb = UIStoryboard(name: "SecondLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SecondLevelViewController") as! SecondLevelViewController
        self.navigationController?.show(vc, sender: self)
    }
    @IBAction func longPressOnLevelTwo(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            showAlert(level: 2)
        }
    }
    
    @IBAction func levelThree(_ sender: Any) {
        let sb = UIStoryboard(name: "ThirdLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ThirdLevelCategoryViewController") as! ThirdLevelCategoryViewController
        self.navigationController?.show(vc, sender: self)
    }
    @IBAction func longPressOnLevelThree(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            showAlert(level: 3)
        }
    }
    
    @IBAction func levelFour(_ sender: Any) {
        let sb = UIStoryboard(name: "FourthLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FourthLevelCategoryViewController") as! FourthLevelCategoryViewController
        self.navigationController?.show(vc, sender: self)
    }
    @IBAction func longPressOnLevelFour(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            showAlert(level: 4)
        }
    }
    
    @IBAction func aboutApp(_ sender: Any) {
        let sb = UIStoryboard(name: "AboutApp", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AboutAppViewController") as! AboutAppViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    private func showAlert(level: Int){
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите выбрать этот этап?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) in
            UserDefaults.standard.set(level, forKey: "defaultVC")
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
