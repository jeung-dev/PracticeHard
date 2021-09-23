//
//  LabelExtension.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import UIKit

//MARK: UILabel
public extension UILabel {

    func setAsMainTitle() {
        self.font = .title
        self.textColor = .txTblack
    }

    /// Label에 attributedString을 준다.
    /// - Parameters:
    ///   - minimumLineHeight: Line Height
    ///   - font: Font
    ///   - kern: 자간
    ///   - txtColor: 글씨색
    ///   - isStrike: 취소선
    ///   - isEllipsis: 일립시스처리
    ///   - textAlignment: 정렬방향
    func setAttributeString(lineHeight minimumLineHeight: CGFloat? = nil, font: UIFont, kern: CGFloat? = nil, txtColor: UIColor, isStrike: Bool? = nil, isEllipsis:Bool? = nil, textAlignment: NSTextAlignment? = nil) {
        let txt = self.text ?? ""
        var attributes: [NSAttributedString.Key:Any] = [.font : font, .foregroundColor : txtColor]

        if let minimumLineHeight = minimumLineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = minimumLineHeight
            if isEllipsis != nil && isEllipsis == true {
                paragraphStyle.lineBreakMode = .byTruncatingTail
            }
            if let alignment = textAlignment {
                paragraphStyle.alignment = alignment
            }

            attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        }
        if let kern = kern {
            attributes.updateValue(kern, forKey: .kern)
        }
        if isStrike != nil && isStrike == true {
            attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .strikethroughStyle)
        }

        let attrString = NSMutableAttributedString(string: txt)
        attrString.addAttributes(attributes, range: txt.fullRange)
        self.attributedText = attrString
    }

    /// 라벨의 부분 Text에 attributedString을 준다.
    /// - Parameters:
    ///   - with: attributedString을 적용할 Text
    ///   - defaultAttrString: base AttributedString
    ///   - minimumLineHeight: Line Height
    ///   - font: Font
    ///   - kern: 자간
    ///   - txtColor: 글씨색
    func setAttributeStringAsPointTextAs(_ with: String?, defaultAttrString: NSAttributedString?, lineHeight minimumLineHeight: CGFloat?, font: UIFont, kern: CGFloat?, txtColor: UIColor, isStrike: Bool? = nil, isEllipsis:Bool? = nil) {

        let txt = self.text ?? ""
        let pointTxt = with ?? ""
        var attributes: [NSAttributedString.Key:Any] = [.font : font, .foregroundColor : txtColor]
        if let minimumLineHeight = minimumLineHeight {
            if isEllipsis != nil && isEllipsis == true {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.minimumLineHeight = minimumLineHeight
                paragraphStyle.lineBreakMode = .byTruncatingTail
                attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
            } else {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.minimumLineHeight = minimumLineHeight
                attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
            }

        }
        if let kern = kern {
            attributes.updateValue(kern, forKey: .kern)
        }
        if isStrike != nil && isStrike == true {
            attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .strikethroughStyle)
        }
        let attrString = defaultAttrString != nil ? NSMutableAttributedString(attributedString: defaultAttrString!) : NSMutableAttributedString(string: txt)
        attrString.addAttributes(attributes, range: (txt as NSString).range(of: pointTxt))
        self.attributedText = attrString
    }

    /// AccessibitlThis text does not support dynamic type. Consider using a UIFont preferred font and setting adjustsFontForContentSizeCategory to YES
    /// 폰트에 Accessibility를 적용합니다.
    /// - Parameters:
    ///   - isAccessibility: accessibility 사용 유무
    ///   - font: 적용할 폰트
    func setAccessibility(_ isAccessibility: Bool, font: UIFont) {
        self.adjustsFontForContentSizeCategory = true
        if #available(iOS 11.0, *) {
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            self.font = fontMetrics.scaledFont(for: font)
        } else {
            // Fallback on earlier versions
            self.font = font
        }
        self.isAccessibilityElement = isAccessibility
        self.accessibilityElementsHidden = !isAccessibility
    }

}
