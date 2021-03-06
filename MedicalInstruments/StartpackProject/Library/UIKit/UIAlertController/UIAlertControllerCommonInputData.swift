//
//  UIAlertControllerCommonInputData.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation

struct UIAlertControllerCommonInputData {
    
    let title: String?
    let message: String?
    let buttons: [Button]
    
    init(
        title: String? = nil,
        message: String? = nil,
        buttons: [UIAlertControllerCommonInputData.Button]
    ) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}

extension UIAlertControllerCommonInputData {
    
    struct Button {
        let title: String
        let action: VoidClosure?
        
        init(
            title: String,
            action: VoidClosure? = nil
        ) {
            self.title = title
            self.action = action
        }
    }
}
