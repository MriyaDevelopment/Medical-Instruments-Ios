//
//  ChangeCategoriesCell.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 11.03.2022.
//

import UIKit

final class ChangeCategoriesCell: UITableViewCell {
    
    private var check = false
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        return view
    }()
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(AppIcons.getIcon(.i_check_off), for: .normal)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 16)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Общая хирургия"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_ECEDF0.uiColor()
        return view
    }()
    
    private var lockedImageView: UIImageView = {
        let image = UIImageView()
        image.image = AppIcons.getIcon(.i_locked)
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        
        addElements()
        addTarget()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
   
    private func addElements() {
        
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(lockedImageView)
        backView.addSubview(checkButton)
        backView.addSubview(lineView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(checkButton.snp.right).offset(19)
            make.bottom.equalTo(checkButton.snp.bottom)
        }
        
        lockedImageView.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(14)
        }
        
        lineView.snp.makeConstraints{ (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.bottom.right.equalToSuperview().offset(-5)
        }
        
    }
    
    func addTarget() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
    }
    
    @objc private func clicked() {
        if check == false {
            checkButton.setImage(AppIcons.getIcon(.i_check_on), for: .normal)
            check = true
        } else {
            checkButton.setImage(AppIcons.getIcon(.i_check_off), for: .normal)
            check = false
        }
    }
}
