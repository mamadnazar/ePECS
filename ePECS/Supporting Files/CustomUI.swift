//
//  CustomUI.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/27/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    @IBInspectable open var isRounded: Bool = false {
        didSet {
            if isRounded {
                layer.cornerRadius = frame.width / 2
            } else {
                layer.cornerRadius = 20
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 2
    }
}

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 12
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        layer.cornerRadius = 12
    }

    override open var isHighlighted: Bool {
        didSet {
            let highlightedColor = UIColor(red: 233, green: 233, blue: 233)
            backgroundColor = isHighlighted ? highlightedColor : UIColor.white
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            let highlightedColor = UIColor(red: 233, green: 233, blue: 233)
            backgroundColor = isHighlighted ? highlightedColor : UIColor.white
        }
    }
}

class CustomButton2: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 12
    }
    
    override open var isHighlighted: Bool {
        didSet {
            let highlightedColor = UIColor(red: 204, green: 73, blue: 86)
            backgroundColor = isHighlighted ? highlightedColor : UIColor.clear
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            let highlightedColor = UIColor(red: 204, green: 73, blue: 86)
            backgroundColor = isHighlighted ? highlightedColor : UIColor.clear
        }
    }
}

