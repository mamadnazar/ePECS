//
//  PhraseCard.swift
//  ePECS
//
//  Created by Fragilehm on 6/20/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import Foundation
import UIKit

class Card: Equatable {
    
    var index: Int
    var name: String
    var image: UIImage
    
    init(index: Int, name: String, image: UIImage) {
        self.index = index
        self.name = name
        self.image = image
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.index == rhs.index
    }
    
}
