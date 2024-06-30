//
//  UIDimension.swift
//  Pollexa
//
//  Created by Eda Bulut on 9.06.2024.
//

import UIKit

enum UIDimensions {
    /// 8 px
    case tiny
    /// 20 px
    case small
    /// 24 px
    case medium
    /// 32 px
    case large
    /// 40 px
    case extraLarge
    
    var value: CGFloat {
        switch self {
            case .tiny:
                return 8.0
            case .small:
                return 20.0
            case .medium:
                return 24.0
            case .large:
                return 32.0
            case .extraLarge:
                return 40.0
        }
    }
}
