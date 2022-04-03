//
//  LaunchScreenView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

final class LaunchScreenView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
