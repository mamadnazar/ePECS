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
                layer.cornerRadius = 15
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
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 2
    }
}

class Curve: UIView {
    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func draw(_ rect: CGRect) {
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2 + 10, y: self.frame.size.height/2), radius: self.frame.size.height/2, startAngle: CGFloat(4.7), endAngle: CGFloat(1.5), clockwise: true)
        
        path.lineWidth = 3
        UIColor.red.setStroke()
        path.stroke()
        
            
    }
    
}

//class CustomButton: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupButton()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        setupButton()
//    }
//
//    private func setupButton() {
//        backgroundColor = Colors.lightRed
//        layer.cornerRadius = frame.height / 2
//        setTitleColor(.white, for: .normal)
//        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//    }
//}

