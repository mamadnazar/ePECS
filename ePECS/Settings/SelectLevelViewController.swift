//
//  SelectLevelViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class SelectLevelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Настройки этапов"
    }
    
    @IBAction func changeLevelOne(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "No changes needed in level one", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeLevelTwo(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeLevelTwoViewController") as! ChangeLevelTwoViewController
        self.navigationController?.show(vc, sender: nil)
    }
    
    @IBAction func changeLevelThree(_ sender: Any) {
    }
    
    @IBAction func changeLevelFour(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
