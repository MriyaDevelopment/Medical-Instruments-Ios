//
//  FirstBanner.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 19.03.2022.
//

import UIKit

final class FirsBannerView: UIView {
    
    var startTestButttonClicked: VoidClosure?
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return view
    }()
    
    private var backgroundImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_backgroundProfileBanner)
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_FFFFFF.uiColor()
        label.text = "Проверь свои знания и пройди тестирование! Это поможет лучше усвоить темы."
        label.numberOfLines = 0
        return label
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_instruments)
        return imageView
    }()
    
    lazy private var tryAgainButton: UIButton = {
        let button = UIButton()
        let imageRightButton = AppIcons.getIcon(.i_arrow_right).withTintColor(.white)
        button.setTitle("Пройти тестирование", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 14)
        button.setTitleColor(BaseColor.hex_FFFFFF.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setImage(imageRightButton, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(contentView)
        contentView.addSubview(backgroundImageVIew)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tryAgainButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backgroundImageVIew.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(-7)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-30)
        }

        tryAgainButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(22)
        }
        
    }
    
    private func addTarget() {
        tryAgainButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(){
        startTestButttonClicked?()
    }
}
