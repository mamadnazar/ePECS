//
//  Constant.swift
//  ePECS
//
//  Created by ITLabAdmin on 6/23/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class Constant {
    static var totalItem: CGFloat = 20
    
    static var column: CGFloat = 4
    
    static let minLineSpacing: CGFloat = 1.0
    static let minItemSpacing: CGFloat = 1.0
    
    static let offset: CGFloat = 1.0 // TODO: for each side, define its offset
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        
        // totalCellWidth = (collectionview width or tableview width) - (left offset + right offset) - (total space x space width)
        let totalWidth = boundWidth - (offset + offset) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
}
