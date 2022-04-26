//
//  InputForm + animations.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit

extension InputForm {
    func animateFilledState() {
        if initialTitleLabelWidth == 0 {
            initialTitleLabelWidth = titleLabel.frame.width
        }
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            let coef = CGFloat(12)/CGFloat(16)
            let scale = CGAffineTransform.init(scaleX: coef, y: coef)
            let transition = CGAffineTransform(translationX: -0.167*self.initialTitleLabelWidth, y: -19) //
            let transform = transition.concatenating(scale)
            self.titleLabel.transform = transform
        }, completion: { _ in
            self.titleLabel.textColor = BaseColor.hex_A5A7AD.uiColor()
            UIView.transition(with: self.titleLabel, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
            //self.isAlreadyAnimated = true
        })
       // titleLabel.hideView()
    }
    
    func animateEmptyState() {
        self.titleLabel.textColor = BaseColor.hex_A5A7AD.uiColor()
        UIView.transition(with: self.titleLabel, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: {_ in
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self = self else { return }
                self.titleLabel.transform = .identity
            }, completion: nil)
            //self.isAlreadyAnimated = false
        })
//        titleLabel.showView()
    }
    
    func setFilledState() {
        if initialTitleLabelWidth == 0 {
            initialTitleLabelWidth = titleLabel.frame.width
        }
        let coef = CGFloat(12)/CGFloat(16)
        let scale = CGAffineTransform.init(scaleX: coef, y: coef)
        let transition = CGAffineTransform(translationX: -0.167*self.initialTitleLabelWidth, y: -19)
        let transform = transition.concatenating(scale)
        titleLabel.transform = transform

        titleLabel.textColor = BaseColor.hex_747474.uiColor()
        self.isAlreadyAnimated = true
        titleLabel.showView()
    }
    
    func setEmptyState() {
        titleLabel.textColor = BaseColor.hex_151515.uiColor()
        titleLabel.transform = .identity
        //self.isAlreadyAnimated = false
        titleLabel.showView()
    }
}
