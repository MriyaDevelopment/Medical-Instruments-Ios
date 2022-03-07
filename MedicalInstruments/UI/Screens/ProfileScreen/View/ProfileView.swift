//
//  ProfileView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

final class ProfileView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_71C324.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        makeConstraints()
    }
    
    private func makeConstraints() {
    }
}
