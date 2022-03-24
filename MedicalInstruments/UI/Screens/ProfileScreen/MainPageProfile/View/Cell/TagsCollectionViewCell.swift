//
//  TagsCollectionViewCell.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = MainFont.medium(size: 12)
        label.setLineHeight(15)
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = BaseColor.hex_5B67CA.uiColor().withAlphaComponent(0.25)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(title: String) {
        
        var color = UIColor()
        
        switch title {
        case "Гинекология":
            color = BaseColor.hex_E77D7D.uiColor()
        case "Стоматология":
            color = BaseColor.hex_5B67CA.uiColor()
        case "Нейрохирургия":
            color = BaseColor.hex_81E89E.uiColor()
        case "Общая хирургия":
            color = BaseColor.hex_7EC3DF.uiColor()
        case "Офтальмология":
            color = BaseColor.hex_EAC566.uiColor()
        case "Отоларингология":
            color = BaseColor.hex_E880CB.uiColor()
        case "Урология":
            color = BaseColor.hex_CC825F.uiColor()
        case "Анестезиология":
            color = BaseColor.hex_BE7EE7.uiColor()
        default:
            color = BaseColor.hex_7EC3DF.uiColor()
        }
        
        titleLabel.text = title
        titleLabel.textColor = color
        backgroundColor = color.withAlphaComponent(0.25)
    }
    
    private func addElements() {
        addSubview(titleLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
