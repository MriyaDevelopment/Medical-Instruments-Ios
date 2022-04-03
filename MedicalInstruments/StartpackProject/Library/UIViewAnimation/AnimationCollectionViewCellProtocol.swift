//
//  AnimationCollectionViewCellProtocol.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 01.04.2022.
//

import UIKit

protocol AnimationCollectionViewCellProtocol: UICollectionViewCell {
    
}

extension AnimationCollectionViewCellProtocol {
    func animationScale(for cell: UICollectionViewCell, indexPath: IndexPath, collectionView: UICollectionView) {
        let animation = AnimationCoolectionViewFactory.scaleTouch(duration: 0.25)
        let animator = AnimatorInitCollectionViewFactory(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: collectionView)
    }
    
    func animationIdentity(for cell: UICollectionViewCell, indexPath: IndexPath, collectionView: UICollectionView) {
        let animation = AnimationCoolectionViewFactory.scaleIdentity(duration: 0.25)
        let animator = AnimatorInitCollectionViewFactory(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: collectionView)
    }
}
