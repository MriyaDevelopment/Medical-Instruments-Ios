//
//  UIImage.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

extension UIImage {
    func setColor(_ color: UIColor) -> UIImage {
        return self.withTintColor(color, renderingMode: .alwaysTemplate)
    }
}
