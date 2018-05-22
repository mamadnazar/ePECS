//
//  ServerManager.swift
//  ePECS
//
//  Created by ITLabAdmin on 5/22/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON

class ServerManager: HTTPRequestManager  {
    
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    
}
