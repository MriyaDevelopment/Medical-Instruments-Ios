//
//  InputForm + UITextFieldDelegate.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit

extension InputForm: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if isUserInput {
            isUserInput = true
            valueChanged?(text)
        }
//        clearIconImageView.isHidden = text.isEmpty
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        isUserInput = true
        state = .normal
        animateFilledState()
        if !text.isEmpty {
//            clearIconImageView.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            animateEmptyState()
        }
        listView.isHidden = true
//        clearIconImageView.isHidden = true
        _ = checkIsValid()
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextForm = self.nextForm else {
            return true
        }
        nextForm.startEditing()
        return true
    }
}

