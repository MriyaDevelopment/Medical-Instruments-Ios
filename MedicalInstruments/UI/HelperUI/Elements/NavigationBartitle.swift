//
//  NavigationBartitle.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import UIKit

final class NavigationBarTitle: UIView {
    
//    var clicked: VoidClosure?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.font = MainFont.regular(size: 20)
        label.sizeToFit()
        label.textAlignment = .left
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.font = MainFont.regular(size: 14)
        label.sizeToFit()
        label.textAlignment = .left
        return label
    }()
    
    init(title: String = "", subTitle: String = "", isInteractable: Bool = false) {
        super.init(frame: .zero)
        titleLabel.text = title
        subTitleLabel.isHidden = subTitle.isEmpty
        subTitleLabel.text = subTitle
        addElements()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(title: String, subTitle: String = "", isInteractable: Bool = false){
        titleLabel.text = title
        subTitleLabel.isHidden = subTitle.isEmpty
        subTitleLabel.text = subTitle
    }
    
    func updateSubTitle(_ value: String) {
        subTitleLabel.text = value
    }
    
    private func addElements() {
        addSubview(stackView)
        mainView.addSubview(titleLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(24)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(17)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
            make.centerY.left.equalToSuperview()
        }
    }
    
//    @objc private func clickAction() {
//        clicked?()
//    }
}
