//
//  UIView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

extension UIView {
    
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        tapGesture.cancelsTouchesInView = false //эта строка нужна чтобы не блокировать didSelectItem у CollectionView и TableView
        addGestureRecognizer(tapGesture)
    }
    
    func addOverlay(color: UIColor = .black, alpha: CGFloat = 0.4) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
    
    func likeSpringTapAnimation() {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: { self.transform = CGAffineTransform(scaleX: 0.72, y: 0.72)
                       }, completion: {_ in
                        UIView.animate(withDuration: 0.15,
                                       delay: 0,
                                       usingSpringWithDamping: 0.4,
                                       initialSpringVelocity: 2,
                                       options: .curveEaseInOut) {
                            self.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }
                       })
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}
