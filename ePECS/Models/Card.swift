//
//  PhraseCard.swift
//  ePECS
//
//  Created by Fragilehm on 6/20/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import Foundation
import UIKit

class Card: NSObject, NSCoding {
    
    var index: Int
    var name: String
    var image: UIImage
    
    init(index: Int, name: String, image: UIImage) {
        self.index = index
        self.name = name
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.index = aDecoder.decodeInteger(forKey: "index")
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.image = aDecoder.decodeObject(forKey: "image") as? UIImage ?? #imageLiteral(resourceName: "add")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.index, forKey: "index")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.image, forKey: "image")
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.index == rhs.index
    }
}

//func archiveBasicCards(cards: [Card]) -> Data {
//    let archivedObject = NSKeyedArchiver.archivedData(withRootObject: NSArray.self)
//    return archivedObject
//}
//
//func retrieveBasicCards() -> [Card] {
//    if let unarchivedObject = UserDefaults.standard.object(forKey: "levelTwoCards") as? Data {
//        return (NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject) as? [Card])!
//    }
//    return []
//}
