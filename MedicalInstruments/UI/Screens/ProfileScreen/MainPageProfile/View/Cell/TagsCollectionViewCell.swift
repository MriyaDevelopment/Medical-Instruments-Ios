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
        var text = String()
        
        switch title {
        case "gynecology":
            color = BaseColor.hex_E77D7D.uiColor()
            text = "Акушерство и гинекология"
        case "stomatology":
            color = BaseColor.hex_5B67CA.uiColor()
            text = "Стоматология"
        case "neuro":
            color = BaseColor.hex_81E89E.uiColor()
            text = "Нейрохирургия"
        case "surgery":
            color = BaseColor.hex_7EC3DF.uiColor()
            text = "Общая хирургия"
        case "ophthalmology":
            color = BaseColor.hex_EAC566.uiColor()
            text = "Офтальмология"
        case "lor":
            color = BaseColor.hex_E880CB.uiColor()
            text = "Отоларингология"
        case "urology":
            color = BaseColor.hex_CC825F.uiColor()
            text = "Урология"
        case "anesthesiology":
            color = BaseColor.hex_BE7EE7.uiColor()
            text = "Анестезиология"
        default:
            break
        }
        
        titleLabel.textColor = color
        backgroundColor = color.withAlphaComponent(0.25)
        titleLabel.text = text
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
