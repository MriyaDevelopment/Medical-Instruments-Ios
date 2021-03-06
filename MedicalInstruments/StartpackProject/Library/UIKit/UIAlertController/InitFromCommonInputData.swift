//
//  InitFromCommonInputData.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

extension UIAlertController {
    
    convenience init(inputData: UIAlertControllerCommonInputData) {
        self.init(title: inputData.title, message: inputData.message, preferredStyle: .alert)
        inputData.buttons
            .map { button in UIAlertAction(title: button.title, style: .default, handler: { _ in button.action?() }) }
            .forEach { self.addAction($0) }
    }
}
