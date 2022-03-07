//
//  UIStackView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        for subview in arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}
