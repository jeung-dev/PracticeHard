//
//  StrokeColorAnimation.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import UIKit

class StrokeColorAnimation: CAKeyframeAnimation {
    override init() {
        super.init()
    }
    
    init(colors: [CGColor], duration: Double) {
        super.init()
        
        self.keyPath = "strokeColor"
        self.values = colors
        self.duration = duration
        self.repeatCount = .greatestFiniteMagnitude
        self.timingFunction = .init(name: .easeInEaseOut)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
