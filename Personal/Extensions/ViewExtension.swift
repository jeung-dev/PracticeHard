//
//  ViewExtension.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import UIKit

public extension UIView {
    func addSubViews(_ views: [Any]) {
        for v in views {
            if v is UIImageView {
                self.addSubview(v as! UIImageView)
            }
            else if v is UILabel {
                self.addSubview(v as! UILabel)
            }
            else if v is UIButton {
                self.addSubview(v as! UIButton)
            }
            else if v is UIView {
                self.addSubview(v as! UIView)
            }
        }
    }
}
