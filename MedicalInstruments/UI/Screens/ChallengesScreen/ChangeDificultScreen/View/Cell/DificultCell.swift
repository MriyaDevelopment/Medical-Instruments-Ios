//
//  DificultCell.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import UIKit
import Combine

final class DuficultTableViewCell: UITableViewCell {
    
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_5B67CA.uiColor().withAlphaComponent(0.25)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 16)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Средний уровень"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var instrumentImageView: UIImageView = {
        let image = UIImageView()
        image.image = AppIcons.getIcon(.i_default_image)
        image.clipsToBounds = true
        return image
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "25 вопросов"
        label.numberOfLines = 0
        return label
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать категории и начать", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 10)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setImage(AppIcons.getIcon(.i_back_button), for: .normal)
        button.imageEdgeInsets.left = 165
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        clipsToBounds = false
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(index: Int){
        var color = UIColor()
        var image = UIImage()
        switch index {
        case 0:
            color = BaseColor.hex_5B67CA.uiColor()
            image = AppIcons.getIcon(.i_default_image)
        case 1:
            color = BaseColor.hex_7FC9E7.uiColor()
            image = AppIcons.getIcon(.i_midDificult)
        case 2:
            color = BaseColor.hex_E77D7D.uiColor()
            image = AppIcons.getIcon(.i_hardDificult)
        default:
            break
        }
        configureColor(color: color)
        instrumentImageView.image = image
    }
    
    private func configureColor(color: UIColor){
        backView.backgroundColor = color.withAlphaComponent(0.25)
        instrumentImageView.image = AppIcons.getIcon(.i_default_image).setColor(color)
        nextButton.setTitleColor(color, for: .normal)
    }
   
    private func addElements() {
        
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(instrumentImageView)
        backView.addSubview(subtitleLabel)
        backView.addSubview(nextButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        instrumentImageView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
            make.height.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(instrumentImageView.snp.right).offset(17)
            make.right.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(instrumentImageView.snp.right).offset(17)
            make.right.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        nextButton.snp.makeConstraints { make in
           make.right.equalToSuperview().offset(-20)
           make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
           make.bottom.equalToSuperview().offset(-15)
        }
        
        
    }
}
