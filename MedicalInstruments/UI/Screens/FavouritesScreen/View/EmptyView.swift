//
//  EmptyView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 24.03.2022.
//

import UIKit

final class EmptyView: UIView {
    
    private var instruments: [Instruments] = []
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_empty_fav)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.numberOfLines = 3
        label.text = "Здесь пока пусто!\n Выбранные вами инструменты будут\n находится здесь."
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        if Keychain.shared.getUserToken() == nil {
            textLabel.text = "Здесь пока пусто!\n Чтобы добавлять инструменты в избранное\n необходимо авторизироваться."
        } else {
            textLabel.text = "Здесь пока пусто!\n Выбранные вами инструменты будут\n находится здесь."
        }
    }
    
    private func addElements() {
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(25)
        }
        
    }
}
