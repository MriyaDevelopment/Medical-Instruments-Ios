//
//  UIImageView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(by imageURL: String, completionHandler: VoidClosure? = nil) {
        guard !imageURL.isEmpty else {
            self.image = AppIcons.getIcon(.i_default_image)
            return
        }
        
        let path = "http://ovz2.j04713753.pqr7m.vps.myjino.ru/image/\(imageURL)"
        guard let url = URL(string: path) else {
            self.image = AppIcons.getIcon(.i_default_image)
            return }
        let placeholderView = ImagePreloaderView()
        
        self.kf.setImage(with: url,
                         placeholder: placeholderView) { (result) in
            switch result {
            case .success(_):
                self.backgroundColor = .clear
            case .failure(let error):
                print(error)
                self.image = AppIcons.getIcon(.i_default_image)
            }
            completionHandler?()
        }
    }
}
