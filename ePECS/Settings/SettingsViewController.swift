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

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.initBasicCards()
        DataManager.shared.initCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Настройки"
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
    
    @IBAction func levelTwo(_ sender: Any) {
        let sb = UIStoryboard(name: "SecondLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SecondLevelViewController") as! SecondLevelViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    @IBAction func levelThree(_ sender: Any) {
        let sb = UIStoryboard(name: "ThirdLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ThirdLevelCategoryViewController") as! ThirdLevelCategoryViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    @IBAction func levelFour(_ sender: Any) {
        let sb = UIStoryboard(name: "FourthLevelStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FourthLevelCategoryViewController") as! FourthLevelCategoryViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
