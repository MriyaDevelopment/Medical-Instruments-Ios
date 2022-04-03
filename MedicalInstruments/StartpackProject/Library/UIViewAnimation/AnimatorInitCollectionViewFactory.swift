//
//  AnimatorInitCollectionViewFactory.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 01.04.2022.
//

import UIKit

typealias AnimationCoolectionView = (UICollectionViewCell, IndexPath, UICollectionView) -> Void

final class AnimatorInitCollectionViewFactory {
    
    private var hasAnimatedAllCells = false
    private let animation: AnimationCoolectionView
    
    init(animation: @escaping AnimationCoolectionView) {
        self.animation = animation
    }
    
    func animate(cell: UICollectionViewCell, at indexPath: IndexPath, in collectionView: UICollectionView) {
        guard !hasAnimatedAllCells else {
            return
        }
        
        animation(cell, indexPath, collectionView)
        
        hasAnimatedAllCells = true
    }
}

enum AnimationCoolectionViewFactory {
    
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> AnimationCoolectionView {
        return { cell, indexPath, _ in
            cell.alpha = 0
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
                })
        }
    }
    
    static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> AnimationCoolectionView {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
        }
    }
    
    static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> AnimationCoolectionView {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight / 2)
            cell.alpha = 0
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
                })
        }
    }
    
    static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> AnimationCoolectionView {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
        }
    }
    
    static func scaleTouch(duration: TimeInterval) -> AnimationCoolectionView {
        return { cell, _, _ in
            UIView.animate(
                withDuration: duration / 2,
                animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                })
            
        }
    }
    
    static func scaleIdentity(duration: TimeInterval) -> AnimationCoolectionView {
        return { cell, _, _ in
            UIView.animate(withDuration: duration / 2) {
                cell.transform = .identity
            }
        }
    }
}

