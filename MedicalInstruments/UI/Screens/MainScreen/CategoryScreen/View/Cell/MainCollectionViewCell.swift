//
//  MainCollectionViewCell.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 08.03.2022.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_otorhinolaryngology)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Общая хирургия"
        label.numberOfLines = 2
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Инструментарий: 40"
        return label
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var nextImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 14
        clipsToBounds = true
        
        addElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(item: MainStruct) {
        self.titleLabel.text = item.titleText
        self.subtitleLabel.text = item.subtitleText
        self.backgroundImageView.image = item.backgroundImage
        self.imageView.image = item.iconImage
    }

    
    private func addElements() {
        
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(subtitleLabel)
        backgroundImageView.addSubview(imageView)
        backgroundImageView.addSubview(nextImageView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(15)
            make.height.width.equalTo(43)
        }
        
        nextImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-14)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(12)
            make.right.equalToSuperview().offset(-10)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(12)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(5)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
    }
}

//Click Animation

extension MainCollectionViewCell: AnimationCollectionViewCellProtocol {

}
