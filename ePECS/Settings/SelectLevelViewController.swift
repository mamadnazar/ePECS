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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Настройки этапов"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        let sb = UIStoryboard(name: "CardsLibraryStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CardsLibraryViewController") as! CardsLibraryViewController
        vc.fromVC = false
        self.navigationController?.show(vc, sender: nil)
    }
    
    @IBAction func changeLevelFour(_ sender: Any) {
        let sb = UIStoryboard(name: "CardsLibraryStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CardsLibraryViewController") as! CardsLibraryViewController
        vc.fromVC = false
        self.navigationController?.show(vc, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
