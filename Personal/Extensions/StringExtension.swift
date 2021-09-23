//
//  StringExtension.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import UIKit

//MARK: String
extension String {
    public var fullRange: NSRange {
        return NSRange(location: 0, length: self.count)
    }

    /// add cancel line
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttributes([NSAttributedString.Key.strikethroughStyle: 2], range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }

    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }

    func cutStringBasedByteLength(someByteLength length: Int) -> String {
        let length: Int = length
        let utf16FromText = self.utf16

        let textCount = utf16FromText.count * 2

        if textCount > length {
            let index = utf16FromText.index(utf16FromText.startIndex, offsetBy: length/2)
            let resultText = utf16FromText[..<index]
            guard let convertString = String(resultText) else {
                Logger.e("Error!!")
                return self
            }
            return convertString
        } else {
            return self
        }
    }

}
