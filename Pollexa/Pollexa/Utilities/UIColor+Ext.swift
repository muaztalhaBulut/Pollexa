//
//  UIColor+Extensions.swift
//  BluetoothScanner
//
//  Created by Talip on 16.12.2022.
//

import UIKit

extension UIColor {
    
    // MARK: - Background
    @nonobjc public class var mainBackground: UIColor {
        return UIColor(r: 248, g: 248, b: 254)
    }
    @nonobjc public class var cellColor: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    @nonobjc public class var activeColor: UIColor {
        return UIColor(r: 88, g: 86, b: 207)
    }
    @nonobjc public class var seperatorColor: UIColor {
        return UIColor(r: 228, g: 228, b: 230)
    }
    @nonobjc public class var subtitleColor: UIColor {
        return UIColor(r: 171, g: 170, b: 230)
    }
   
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}
