//
//  PrettyAlertView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Combine

final class PrettyAlertView: UIView {
    
    let events = PassthroughSubject<PrettyAlertViewEvent, Never>()
    
    private let visibleStateAlpha: CGFloat = 0.2
    
    private var actionBlockBackView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_alert)
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 18)
        label.numberOfLines = 0
        label.textColor = BaseColor.hex_151515.uiColor()
        label.text = "Лучшее короткое название"
        label.textAlignment = .center
        return label
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 15)
        label.numberOfLines = 0
        label.textColor = BaseColor.hex_151515.uiColor()
        label.text = "Сообщение должно быть коротким,\nзаконченное предложение."
        label.textAlignment = .center
        return label
    }()
    
    private var buttonsBackView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_E5E5E5.uiColor()
        return view
    }()
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(visibleStateAlpha)
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(initInfo: PrettyAlertInitialization) {
        titleLabel.text = initInfo.title
        titleLabel.setLineHeight(22, alignment: .center)
        messageLabel.text = initInfo.message
        messageLabel.setLineHeight(16, alignment: .center)
        
        for (index, buttonInfo) in initInfo.buttons.enumerated() {
            
            let button = UIButton()
            button.setTitle(buttonInfo.title, for: .normal)
            button.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
            
            switch buttonInfo.type {
            case .standart:
                button.titleLabel?.font = MainFont.regular(size: 16)
                button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
            case .action:
                button.titleLabel?.font = MainFont.medium(size: 16)
                button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
            }
            
            button.snp.makeConstraints { (make) in
                make.height.equalTo(43)
            }
            
            buttonsStackView.addArrangedSubview(button)
            
            button.tag = index
            button.addTarget(self, action: #selector(buttonClickedAction(_:)), for: .touchUpInside)
        }
        
        backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(0)
        
        actionBlockBackView.alpha = 0
        actionBlockBackView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)

    }
    
    func present() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(self.visibleStateAlpha)
            self.actionBlockBackView.alpha = 1
            self.actionBlockBackView.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func buttonClickedAction(_ sender: UIButton) {
        events.send(.buttonClicked(sender.tag))
    }
    
    private func addElements() {
        
        addSubview(actionBlockBackView)
        actionBlockBackView.addSubview(iconImageView)
        actionBlockBackView.addSubview(titleLabel)
        actionBlockBackView.addSubview(messageLabel)
        
        actionBlockBackView.addSubview(buttonsBackView)
        buttonsBackView.addSubview(buttonsStackView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        actionBlockBackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(19)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        buttonsBackView.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
