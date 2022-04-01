//
//  UICollectionView + SelectItem.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 01.04.2022.
//

import UIKit

extension UICollectionView {
    
    func didHighlightRowAt(at indexPath: IndexPath) {
        guard let cell = self.cellForItem(at: indexPath) as? AnimationCollectionViewCellProtocol else { return }
        cell.animationScale(for: cell, indexPath: indexPath, collectionView: self)
    }
    
    func didUnhighlightRowAt(at indexPath: IndexPath) {
        guard let cell = self.cellForItem(at: indexPath) as? AnimationCollectionViewCellProtocol else { return }
        cell.animationIdentity(for: cell, indexPath: indexPath, collectionView: self)
    }
}

// MARK: Применение
// В ячейке ->
//Подписаться на протокол AnimationCollectionViewCellProtocol
// Во вью ->
//func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//   collectionView.didHighlightRowAt(at: indexPath)
//}
//func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//   collectionView.didUnhighlightRowAt(at: indexPath)
//}
