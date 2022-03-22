//
//  InputForm.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit
import InputMask

class InputForm: UIView {
    
    //MARK: Closures
    
    var clickedSuggestionItem: IntClosure?
    var valueChanged: StringClosure?
    
    //MARK: Fields
    
    lazy var nextForm: InputForm? = nil {
        didSet {
            textField.returnKeyType = .next
        }
    }
    
    var isValid: Bool {
        get {
            checkIsValid()
        }
    }
    
    let type: InputFormType
    let isRequired: Bool
    let placeholder: String
    let isFilledState = false
    
    let title: String
    
    var isUserInput = true
    
    var inputMask: MaskedTextFieldDelegate!
    
    var predicate: NSPredicate?
    
    var initialTitleLabelWidth: CGFloat = 0
    
    var requiredSymbolIsHidden: Bool = false {
        didSet {
            titleLabel.text = requiredSymbolIsHidden ? title : "\(title) *"
        }
    }
    
    var isActive: Bool = true {
        didSet {
            textField.textColor = isActive ? BaseColor.hex_151515.uiColor() : BaseColor.hex_A5A7AD.uiColor()
            backView.isUserInteractionEnabled = isActive
        }
    }
    
    var state: InputFormState = .disable {
        didSet {
            switch state {
            case .errorFilled:
                warningBorderView.layer.borderColor = BaseColor.hex_FF5F22.cgColor()
                warningBorderView.layer.borderWidth = 1
            case .errorNotFilled:
                warningBorderView.layer.borderColor = BaseColor.hex_FF5F22.cgColor()
                warningBorderView.layer.borderWidth = 1
            case .normal:
                warningBorderView.layer.borderWidth = 1
                warningBorderView.layer.borderColor = BaseColor.hex_ECEDF0.cgColor()
                messageLabel.isHidden = true
            default:
                break
            }
        }
    }
    
    var isAlreadyAnimated = false
    
    //MARK: UIElements
    
    let mainSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_E5E5E5.uiColor()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        
        return view
    }()
    
    let warningBorderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = BaseColor.hex_ECEDF0.cgColor()
        return view
    }()
    
    let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_A5A7AD.uiColor()
        label.font = MainFont.regular(size: 14)
        label.text = placeholder
        
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = BaseColor.hex_151515.uiColor()
        textField.font = MainFont.regular(size: 14)

        textField.tintColor = BaseColor.hex_151515.uiColor()
        return textField
    }()
    
    var clearIconImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = AppIcons.getIcon(.ic_close)
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        return imageView
    }()

    var listView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_F1F1F1.uiColor()
        view.isHidden = true
        return view
    }()
    
    let separatorsView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_E5E5E5.uiColor()
        return view
    }()
    
    var suggestionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 13)
        label.textColor = BaseColor.hex_FF5F22.uiColor()
        label.isHidden = true
        return label
    }()
    
    init(type: InputFormType, isRequired: Bool, placeholder: String) {
        self.type = type
        self.isRequired = isRequired
        self.placeholder = placeholder
        self.title = placeholder
        super.init(frame: .zero)
        
        
        textField.delegate = self
        
        configure()
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(_ value: String) {
        isUserInput = false
        
        guard let text = textField.text, text.isEmpty != value.isEmpty else {
            textField.text = value
            return
        }
        
        if type == .phoneNumber {
            inputMask.put(text: value, into: textField)
        } else {
            textField.text = value
        }
        
        if value.isEmpty {
            setEmptyState()
        } else {
            setFilledState()
        }
        
        _ = checkIsValid()
    }
    
    func getValue() -> String {
        guard let text = textField.text else { return "" }
        return text
    }
    
    func setSuggestionsList(list: [SuggestionItemProtocol]) {
        suggestionsStackView.removeAllArrangedSubviews()

        listView.isHidden = list.isEmpty
        
        for (index, info) in list.enumerated() {
            let item = SuggestionsListItem()
            item.update(title: info.title, subtitle: info.subTitle)
            item.clicked = { [weak self] in
                self?.listView.isHidden = true
                self?.endEditing()
                self?.clickedSuggestionItem?(index)
            }
            suggestionsStackView.addArrangedSubview(item)
        }
    }
    
    func checkIsValid() -> Bool {
        
        guard let text = textField.text else { return false }

        if isRequired {
            if text.isEmpty {
                state = .errorNotFilled
                return false
            } else {
                guard let predicate = self.predicate else {
                    state = .normal
                    return true
                }
                
                if predicate.evaluate(with: text) {
                    state = .normal
                    return true
                } else {
                    state = .errorFilled
                    return false
                }
            }
        } else {
            if text.isEmpty {
                state = .normal
                return true
            } else {
                guard let predicate = self.predicate else {
                    state = .normal
                    return true
                }
                
                if predicate.evaluate(with: text) {
                    state = .normal
                    return true
                } else {
                    state = .errorFilled
                    return false
                }
            }
        }
    }
    
    private func configure() {
        switch type {
        case .email:
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            
            let firstpart = "[A-Z0-9a-z_%+-]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
            let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
            let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
            predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            
        case .phoneNumber:
            textField.keyboardType = .phonePad
            inputMask = MaskedTextFieldDelegate(
                primaryFormat: "+7 [900] [000]-[00]-[00]"
            )
            textField.delegate = inputMask
            inputMask.listener = self
            
            let phoneRegex = "^\\+7" + " " + "9[0-9]{2}" + " " + "[0-9]{3}" + "-" + "[0-9]{2}" + "-" + "[0-9]{2}"
            predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            
        case .name:
            textField.autocapitalizationType = .words
        case .postalCode:
            textField.keyboardType = .numberPad
            let postalCodeRegex = "[0-9]{6}"
            predicate = NSPredicate(format: "SELF MATCHES %@", postalCodeRegex)
            inputMask = MaskedTextFieldDelegate(
                primaryFormat: "[000000]"
            )
            textField.delegate = inputMask
            inputMask.listener = self
        
        case .password:
            textField.isSecureTextEntry = true
            textField.autocapitalizationType = .none
        default:
            break
        }
    }
    

    
    private func addTargets() {
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewClicked)))
        clearIconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearButtonClicked)))
    }
    
    @objc private func backViewClicked() {
        startEditing()
    }
    
    @objc private func clearButtonClicked() {
        textField.text = ""
    }
    
    func startEditing() {
        textField.becomeFirstResponder()
    }
    
    func endEditing() {
        textField.endEditing(true)
    }
    
}

extension InputForm: MaskedTextFieldDelegateListener {
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        guard let text = textField.text else { return }
        if isUserInput {
            isUserInput = true
            valueChanged?(text)
        }
    }
}

