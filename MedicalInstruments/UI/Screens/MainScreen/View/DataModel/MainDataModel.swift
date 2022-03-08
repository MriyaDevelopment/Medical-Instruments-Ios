//
//  MainDataModel.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 08.03.2022.
//

import Foundation
import UIKit

enum MainViewEvent {
    case cellClicked(Int)
}

struct MainStruct {
    var id: Int
    var backgroundImage: UIImage
    var iconImage: UIImage
    var titleText: String
    var subtitleText: String
}
