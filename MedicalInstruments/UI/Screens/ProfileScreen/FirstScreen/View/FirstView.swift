//
//  AuthViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import Combine
import UIKit

final class FirstView: UIView {
    
    var events = PassthroughSubject<FirstVeiwEvents, Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_authImage)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_logo)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Начни изучать хирургию вместе с мобильным справочником медицинских инструментов"
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        button.layer.cornerRadius = 15
        button.setTitleColor(BaseColor.hex_FFFFFF.uiColor(), for: .normal)
        return button
    }()
    
    private var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 14)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        
        addSubview(contentView)
        contentView.addSubview(titleImageView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(textLabel)
        contentView.addSubview(authButton)
        contentView.addSubview(registrationButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints {(make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        titleImageView.snp.makeConstraints {(make) in
            make.left.right.top.equalToSuperview().inset(16)
            make.height.equalTo(240)
        }
        
        logoImageView.snp.makeConstraints {(make) in
            make.top.equalTo(titleImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        textLabel.snp.makeConstraints {(make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        authButton.snp.makeConstraints {(make) in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        registrationButton.snp.makeConstraints {(make) in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func addTarget() {
        authButton.addTarget(self, action: #selector(authAction), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(regAction), for: .touchUpInside)
    }
    
    @objc func authAction() {
        events.send(.authClicked)
    }
    
    @objc func regAction() {
        events.send(.regClicked)
    }
}
