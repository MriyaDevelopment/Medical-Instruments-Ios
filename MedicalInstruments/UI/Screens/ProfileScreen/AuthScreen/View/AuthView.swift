//
//  AuthView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit
import Combine

final class AuthView: UIView {
    
    var events = PassthroughSubject<AuthViewEvent, Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var emailInputForm: InputForm = {
        let view = InputForm(type: .email, isRequired: true, placeholder: "E-mail")
        return view
    }()
    
    var passwordInputForm: InputForm = {
        let view = InputForm(type: .password, isRequired: true, placeholder: "Пароль")
        return view
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
        contentView.addSubview(emailInputForm)
        contentView.addSubview(passwordInputForm)
        contentView.addSubview(authButton)
        contentView.addSubview(registrationButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints{ (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        emailInputForm.snp.makeConstraints{ (make) in
            make.left.right.top.equalToSuperview().inset(16)
        }
        
        passwordInputForm.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(emailInputForm.snp.bottom).offset(20)
        }
        
        authButton.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(passwordInputForm.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        registrationButton.snp.makeConstraints {(make) in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func addTarget(){
        authButton.addTarget(self, action: #selector(authAction), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(regAction), for: .touchUpInside)
    }
    
    @objc func authAction() {
        events.send(.authButtonClicked)
    }
    
    @objc func regAction() {
        events.send(.regButtonClicked)
    }
}
