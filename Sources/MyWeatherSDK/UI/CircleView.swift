//
//  CircleView.swift
//  MyWeatherApp
//
//  Created by Milan Parađina on 24.10.2022..
//

import Foundation
import UIKit


class CircleView: UIView {
    let utils = Utilities()
    var semiCirleLayer: CAShapeLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let arcCenter = CGPoint(x: bounds.size.width / 2, y: bounds.size.height)
        let circleRadius = bounds.size.width / 2.1
        
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
        
        semiCirleLayer.path = circlePath.cgPath
        
        
        if utils.getHours() > 6 && utils.getHours() <= 18 {
            semiCirleLayer.fillColor = UIColor.systemGreen.cgColor
        } else {
            semiCirleLayer.fillColor = UIColor.systemBlue.cgColor
        }
        
        semiCirleLayer.name = "RedCircleLayer"
        semiCirleLayer.cornerRadius = 10

        if !(layer.sublayers?.contains(where: {$0.name == "RedCircleLayer"}) ?? false) {
            layer.addSublayer(semiCirleLayer)           
        }
        
        // Make the view color transparent
        backgroundColor = UIColor.clear
        semiCirleLayer.needsDisplayOnBoundsChange = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
