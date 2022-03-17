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
        titleLabel.text = title
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
