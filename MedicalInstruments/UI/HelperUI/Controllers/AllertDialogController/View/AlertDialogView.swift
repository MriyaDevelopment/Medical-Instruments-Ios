//
//  AlertDialogView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit
import Combine

final class AlertDialogView: UIView {
    
    let events = PassthroughSubject<MainPageViewEvent, Never>()
    
    private let visibleStateAlpha: CGFloat = 0.2
    
    private var actionBlockBackView: UIButton = {
        let view = UIButton()
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 18)
        label.numberOfLines = 0
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Выйти из аккаунта?"
        label.textAlignment = .center
        return label
    }()
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Да", for: .normal)
        button.setTitleColor(BaseColor.hex_FFFFFF.uiColor(), for: .normal)
        button.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var noButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        button.setTitle("Нет", for: .normal)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(visibleStateAlpha)
        
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func present() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(self.visibleStateAlpha)
            self.actionBlockBackView.alpha = 1
            self.actionBlockBackView.transform = CGAffineTransform.identity
        }
    }
    
    private func addElements() {
        
        addSubview(actionBlockBackView)
        actionBlockBackView.addSubview(titleLabel)
        actionBlockBackView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(noButton)
        buttonsStackView.addArrangedSubview(yesButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        actionBlockBackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(36)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.right.bottom.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    private func addTarget() {
        noButton.addTarget(self, action: #selector(noClickedAction), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(yesClickedAction), for: .touchUpInside)
    }
    
    @objc private func yesClickedAction() {
        events.send(.yesButtonClicked)
    }
    
    @objc private func noClickedAction() {
        events.send(.noButtonClicked)
    }
}
