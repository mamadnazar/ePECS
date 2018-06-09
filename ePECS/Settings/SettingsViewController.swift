//
//  SettingsViewController.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/9/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width: CGFloat = 240.0
        let height: CGFloat = 160.0
        
        let curve = Curve(frame: CGRect(x: self.view.frame.size.width / 2 - width / 2,
                                        y: self.view.frame.size.height / 2 - height / 2,
                                        width: width,
                                        height: height))
        
        self.view.addSubview(curve)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
