//
//  AppIcons.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

final class AppIcons {
    
    enum iconsEnum {
        case i_logo
        case i_main
        case i_challenges
        case i_favourites
        case i_profile
        case i_back_button
        case i_default_image
    }
    
    static func getIcon(_ type: iconsEnum) -> UIImage {
        switch type {
        case .i_logo: return UIImage(named: "i_logo")!
        case .i_main: return UIImage(named: "i_main")!
        case .i_challenges: return UIImage(named: "i_challenges")!
        case .i_favourites: return UIImage(named: "i_favourites")!
        case .i_profile: return UIImage(named: "i_profile")!
        case .i_back_button: return UIImage(named: "i_back_button")!
        case .i_default_image: return UIImage(named: "i_default_image")!
        }
    }
}
