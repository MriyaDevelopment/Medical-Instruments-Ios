//
//  RegistrationScreen.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 16.03.2022.
//


import UIKit
import Combine

final class RegistrationView: UIView {
    
    var events = PassthroughSubject<RegistrationViewEvents, Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var nameInputForm: InputForm = {
        let inputForm = InputForm(type: .name, isRequired: true, placeholder: "Ваше имя")
        return inputForm
    }()
    
    var emailInputForm: InputForm = {
        let inputForm = InputForm(type: .email, isRequired: true, placeholder: "E-mail")
        return inputForm
    }()
    
    var passwordInputForm: InputForm = {
        let inputForm = InputForm(type: .password, isRequired: true, placeholder: "Пароль (не менее 6 символов)")
        return inputForm
    }()
    
    var passwordRepeatInputForm: InputForm = {
        let inputForm = InputForm(type: .password, isRequired: true, placeholder: "Повторите пароль")
        return inputForm
    }()
    
    private var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        button.layer.cornerRadius = 15
        button.setTitleColor(BaseColor.hex_FFFFFF.uiColor(), for: .normal)
        return button
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_5B67CA.uiColor().withAlphaComponent(0.5)
        return view
    }()
    
    private var orLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "или"
        label.textColor = BaseColor.hex_5B67CA.uiColor().withAlphaComponent(0.5)
        label.font = MainFont.medium(size: 12)
        label.textAlignment = .center
        return label
    }()
    
    private var authStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
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
        contentView.addSubview(nameInputForm)
        contentView.addSubview(emailInputForm)
        contentView.addSubview(passwordInputForm)
        contentView.addSubview(passwordRepeatInputForm)
        contentView.addSubview(regButton)
        contentView.addSubview(lineView)
        lineView.addSubview(orLabel)
        contentView.addSubview(authStackView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        nameInputForm.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(16)
        }
        
        emailInputForm.snp.makeConstraints { (make) in
            make.top.equalTo(nameInputForm.snp.bottom).offset(22)
            make.left.right.equalToSuperview().inset(16)
        }
        
        passwordInputForm.snp.makeConstraints { (make) in
            make.top.equalTo(emailInputForm.snp.bottom).offset(22)
            make.left.right.equalToSuperview().inset(16)
        }
        
        passwordRepeatInputForm.snp.makeConstraints { (make) in
            make.top.equalTo(passwordInputForm.snp.bottom).offset(22)
            make.left.right.equalToSuperview().inset(16)
        }
        
        regButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordRepeatInputForm.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
    }
    
    func addTarget() {
        regButton.addTarget(self, action: #selector(regAction), for: .touchUpInside)
    }
    
    @objc func regAction() {
        if nameInputForm.isValid &&
            emailInputForm.isValid &&
            passwordInputForm.getValue().count > 6 &&
            passwordRepeatInputForm.getValue().count > 6 {
            events.send(.registrationButtonClicked)
        } else {
            regButton.shake()
            emailInputForm.checkIsValid()
            nameInputForm.checkIsValid()
            passwordInputForm.checkIsValid()
            passwordRepeatInputForm.checkIsValid()
        }
    }

}
