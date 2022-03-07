//
//  CustomUISegmentedControl.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit


final class CustomUISegmentedControl: UIView {
    
    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.backgroundColor = BaseColor.hex_E7EDF0.uiColor()
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(stackView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(42)
        }
    }
}
