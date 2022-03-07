//
//  FontScheme.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

#warning("Change Base Font")
enum MainFont {
    static func semiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Semibold", size: size) else { return UIFont() }
        return font
    }
    
    static func bold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Bold", size: size) else { return UIFont() }
        return font
    }
        
    static func regular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Regular", size: size) else { return UIFont() }
        return font
    }
    
    static func medium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Medium", size: size) else { return UIFont() }
        return font
    }
}
