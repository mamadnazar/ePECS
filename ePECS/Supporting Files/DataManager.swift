//
//  DataManager.swift
//  ePECS
//
//  Created by ITLabAdmin on 5/22/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    class var shared: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
    
}
