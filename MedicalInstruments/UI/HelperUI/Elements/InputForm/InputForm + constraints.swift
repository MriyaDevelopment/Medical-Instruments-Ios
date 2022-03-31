//
//  InputForm + constraints.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit

extension InputForm {
    func addElements() {
        
        addSubview(mainSeparatorView)
        mainSeparatorView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(backView)
        backView.addSubview(warningBorderView)
        backView.addSubview(inputStackView)
        
        addSubview(messageLabel)
        
        containerView.addSubview(textField)
        containerView.addSubview(titleLabel)
        containerView.addSubview(leftImageView)

        inputStackView.addArrangedSubview(containerView)
//        inputStackView.addArrangedSubview(clearIconImageView)
        
        mainStackView.addArrangedSubview(listView)
        listView.addSubview(separatorsView)
        listView.addSubview(suggestionsStackView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        
        mainSeparatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backView.snp.makeConstraints { (make) in
            make.height.equalTo(45)
        }
        
        warningBorderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        inputStackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(5)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(5)
            make.right.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
        
//        clearIconImageView.snp.makeConstraints { (make) in
//            make.height.width.equalTo(30)
//        }
        
        separatorsView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(21)
            make.right.equalToSuperview().offset(-21)
            make.top.bottom.equalToSuperview()
        }
        
        suggestionsStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.bottom)//.offset(2)
            make.left.equalTo(backView.snp.left)
        }
    }
}
