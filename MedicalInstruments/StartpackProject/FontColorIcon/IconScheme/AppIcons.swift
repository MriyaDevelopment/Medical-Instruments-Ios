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
        case i_main_selected
        case i_surgery_back
        case i_AiG
        case i_ophthalmology
        case i_dentistry
        case i_neurosurgery
        case i_otorhinolaryngology
        case i_logout
        case i_like_enable
        case i_like_disable
        case i_check_on
        case i_check_off
        case i_locked
        case i_backgroundImage
        case i_timerImage
        case i_challenges_eneble
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
        case .i_main_selected: return UIImage(named: "i_main_selected")!
        case .i_surgery_back: return UIImage(named: "i_surgery_back")!
        case .i_AiG: return UIImage(named: "i_AiG")!
        case .i_ophthalmology: return UIImage(named: "i_ophthalmology")!
        case .i_dentistry: return UIImage(named: "i_dentistry")!
        case .i_neurosurgery: return UIImage(named: "i_neurosurgery")!
        case .i_otorhinolaryngology: return UIImage(named: "i_otorhinolaryngology")!
        case .i_logout: return UIImage(named: "i_logout")!
        case .i_like_enable: return UIImage(named: "i_like_enable")!
        case .i_like_disable: return UIImage(named: "i_like_disable")!
        case .i_check_on: return UIImage(named: "i_check_on")!
        case .i_check_off: return UIImage(named: "i_check_off")!
        case .i_locked: return UIImage(named: "i_locked")!
        case .i_backgroundImage: return UIImage(named: "i_backgroundImage")!
        case .i_timerImage: return UIImage(named: "i_timerImage")!
        case .i_challenges_eneble: return UIImage(named: "i_challenges_eneble")!
        }
    }
}
