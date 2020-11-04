//
//  String.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation
import UIKit

extension String {

    var htmlToAttributedString: NSMutableAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8)
            else { return nil }
        do {
            let attrStr = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byTruncatingTail
            let range = NSRange(location: 0, length: attrStr.mutableString.length)
            attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            attrStr.setFontFace(font: .systemFont(ofSize: 16), color: UIColor(named: "textColor"))
            return attrStr
        } catch let error as NSError {
            print("string extention \(error.localizedDescription)")
            return nil
        }
    }
}

extension NSMutableAttributedString {

    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { (value, range, stop) in
            if let f = value as? UIFont, let newFontDescriptor = f.fontDescriptor.withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits) {
                let newFont = UIFont(descriptor: newFontDescriptor, size: font.pointSize)
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(.foregroundColor, range: range)
                    addAttribute(.foregroundColor, value: color, range: range)
                }
            }
        }
        endEditing()
    }
}
