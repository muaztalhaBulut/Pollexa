//
//  String+Ext.swift
//  Pollexa
//
//  Created by Eda Bulut on 9.06.2024.
//


import UIKit

extension String {
    func underlined(withColor color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
