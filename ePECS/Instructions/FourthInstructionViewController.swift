//
//  FourthInstructionViewController.swift
//  ePECS
//
//  Created by ITLabAdmin on 7/31/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class FourthInstructionViewController: UIViewController {

    @IBOutlet weak var startAdventure: UIButton! {
        didSet {
            self.startAdventure.layer.cornerRadius = 20
        }
    }
    @IBAction func startAdventure(_ sender: Any) {
        let sb = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

}
