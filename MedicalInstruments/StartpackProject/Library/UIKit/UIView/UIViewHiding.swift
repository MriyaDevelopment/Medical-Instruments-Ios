//
//  UIViewHiding.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Foundation

extension UIView {
    
    func hideView() {
        guard !isHidden else { return }
        isHidden = true
    }
    
    func showView() {
        guard isHidden else { return }
        isHidden = false
    }
    
    func hideWithAnimateAlpha(duration: TimeInterval) {
        guard !isHidden else { return }
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
        isHidden = true
        self.alpha = 1
    }
    
    func showWithAnimateAlpha(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }
    
    func hideWithScale(duration: TimeInterval) {
        guard !isHidden else { return }
        UIView.animate(withDuration: duration) {
            let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.transform = scale
        } completion: { (_) in
            self.transform = .identity
            self.isHidden = true
        }
    }
    
    func showWithScale(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.transform = scale
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
    
    func hideToLeft(duration: TimeInterval) {
        guard !isHidden else { return }
        UIView.animate(
            withDuration: duration,
            delay: 0,
            animations: {
                let transition = CGAffineTransform(translationX: -1000, y: 0)
                self.transform = transition
            },
            completion: { (_) in
                self.isHidden = true
                self.transform = .identity
            }
        )
    }
    
    func showFromLeft(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        let transition = CGAffineTransform(translationX: -1000, y: 0)
        self.transform = transition
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
    
    func hideToRight(duration: TimeInterval) {
        guard !isHidden else { return }
        UIView.animate(
            withDuration: duration,
            animations: {
                let transition = CGAffineTransform(translationX: 1000, y: 0)
                self.transform = transition
            },
            completion: { (_) in
                self.isHidden = true
                self.transform = .identity
            }
        )
    }
    
    func showFromRight(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        let transition = CGAffineTransform(translationX: 1000, y: 0)
        self.transform = transition
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
    
    func hideToTop(duration: TimeInterval) {
        guard !isHidden else { return }
        UIView.animate(
            withDuration: duration,
            delay: 0,
            animations: {
                let transition = CGAffineTransform(translationX: 0, y: -1000)
                self.transform = transition
            },
            completion: { (_) in
                self.isHidden = true
                self.transform = .identity
            }
        )
    }
    
    func showFromTop(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        let transition = CGAffineTransform(translationX: 0, y: -1000)
        self.transform = transition
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
    
    func showFromDown(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        let transition = CGAffineTransform(translationX: 0, y: 1000)
        self.transform = transition
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
}
