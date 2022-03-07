//
//  SchemeColor.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

enum ColorSchemeOption {
    case dark
    case light
}

struct SchemeColor {
    
    let dark: UIColor
    let light: UIColor

    func uiColor() -> UIColor {
        return colorWith(scheme: ColorScheme.shared.schemeOption)
    }
    
    func cgColor() -> CGColor {
        return uiColor().cgColor
    }
    
    private func colorWith(scheme: ColorSchemeOption) -> UIColor {
        switch scheme {
        case .dark: return dark
        case .light: return light
        }
    }

    // ColorScheme
    struct ColorScheme {
        
        static let shared = ColorScheme()
        private (set) var schemeOption: ColorSchemeOption
        
        private init() {
            //Настройки выбора темы
            let interfaceStyle = UITraitCollection.current.userInterfaceStyle
            switch interfaceStyle {
            case .dark:
                self.schemeOption = .light
            default:
                self.schemeOption = .light
            }
        }
    }
}
