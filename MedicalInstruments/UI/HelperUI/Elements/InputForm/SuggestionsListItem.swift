//
//  SuggestionsListItem.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit

final class SuggestionsListItem: UIView {
    
    var clicked: VoidClosure?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 16)
        label.textColor = BaseColor.hex_151515.uiColor()
        label.numberOfLines = 0
        label.setLineHeight(19, alignment: .left)
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 12)
        label.textColor = BaseColor.hex_A6A6A6.uiColor()
        label.numberOfLines = 0
        label.setLineHeight(15, alignment: .left)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_F1F1F1.uiColor()
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String, subtitle: String) {
        titleLabel.text = title
        //subtitleLabel.text = subtitle
    }
    
    private func addElements() {
        
        addSubview(titleLabel)
        //addSubview(subtitleLabel)
        
        makeConstraints()
    }
    
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.left.equalToSuperview().offset(21)
            make.right.equalToSuperview().offset(-21)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(9)
            make.bottom.lessThanOrEqualToSuperview().offset(-6)
        }
        
        snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(50)
        }
        
//        subtitleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(titleLabel.snp.bottom)
//            make.left.equalToSuperview().offset(21)
//            make.right.equalToSuperview().offset(-21)
//            make.bottom.equalToSuperview().offset(-6)
//        }
    }
    
    private func addTargets() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClicked)))
    }
    
    @objc private func itemClicked() {
        clicked?()
    }
}
