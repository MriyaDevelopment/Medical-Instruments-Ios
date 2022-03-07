//
//  UIViewAnimation.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

extension UIView {
    
    func animationScaleForButtons(for view: UIView, completion: @escaping((Bool) -> Void)) {
        UIView.animate(
            withDuration: 0.1,
            animations: {
                view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            },
            completion: { [ weak self ] (finished) in
                guard let self = self, finished else { return }
                self.returnViewTransform(for: view, duration: 0.1) { (stopAnimation) in
                    guard stopAnimation else { return }
                    completion(stopAnimation)
                }
            })
    }
    
    func returnViewTransform(for view: UIView, duration: TimeInterval, completion: @escaping((Bool) -> Void)) {
        UIView.animate(
            withDuration: duration,
            animations: {
                view.transform = .identity
            },
            completion: { (finished) in
                guard finished else { return }
                completion(true)
            })
    }
}
