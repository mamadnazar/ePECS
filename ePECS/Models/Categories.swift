//
//  Categories.swift
//  ePECS
//
//  Created by User on 7/3/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import Foundation

class Categories: NSObject, NSCoding {
    
    var categoryName: String
    var cards: [Card]
    
    init(categoryName: String, cards: [Card]) {
        self.categoryName = categoryName
        self.cards = cards
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.categoryName = aDecoder.decodeObject(forKey: "categoryName") as? String ?? ""
        self.cards = aDecoder.decodeObject(forKey: "cards") as? Array ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.categoryName, forKey: "categoryName")
        aCoder.encode(self.cards, forKey: "cards")
    }
    
}
