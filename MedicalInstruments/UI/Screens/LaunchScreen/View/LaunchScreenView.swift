//
//  LaunchScreenView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

final class LaunchScreenView: UIView {
    
    private let imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_logo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(imageLogo)
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageLogo.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
