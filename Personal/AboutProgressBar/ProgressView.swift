//
//  ProgressView.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import UIKit


class ProgressView: UIView {
    
    //MARK: - Properties
    let colors: [UIColor]
    let lineWidth: CGFloat
    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()
    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                self.animationStroke()
                self.animationRotation()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
    
    //MARK: - initialization
    init(frame: CGRect, colors: [UIColor], lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
//        self.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.3)
    }
    
    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        
        shapeLayer.path = path.cgPath
    }
    
    //MARK: - Animations
    func animationStroke() {
        let startAnimation = StrokeAnimation(type: .start, beginTime: 0.25, fromValue: 0.0, toValue: 1.0, duration: 0.75)
        let endAnimation = StrokeAnimation(type: .end, fromValue: 0.0, toValue: 1.0, duration: 0.75)
        let strokeAnimationGroup = CAAnimationGroup()
        
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let colorAnimation = StrokeColorAnimation(colors: colors.map({ $0.cgColor }), duration: strokeAnimationGroup.duration * Double(colors.count))
        
        shapeLayer.add(colorAnimation, forKey: nil)
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    func animationRotation() {
        let rotationAnimation = RotationAnimation(direction: .z, fromValue: 0, toValue: CGFloat.pi * 2, duration: 2, repeatCount: .greatestFiniteMagnitude)
        
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
}



