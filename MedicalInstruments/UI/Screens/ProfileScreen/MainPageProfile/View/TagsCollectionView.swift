//
//  TagsCollectionView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import UIKit

final class TagsCollectionView: UIView {
    
    var items: [String] = []
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.clipsToBounds = false
        return stackView
    }()
    
    lazy private var layout: TagFlowLayout = {
        let layout = TagFlowLayout()
        return layout
    }()
    
    lazy private var tagsCollectionView: UICollectionView = {

        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(TagCollectionViewCell.self)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        addElements()
//        layout.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: [String]) {
//        let layout = TagsLayout()
//        layout.sectionInset = .zero
//        layout.delegate = self
//        tagsCollectionView.setCollectionViewLayout(layout, animated: true)
        items.removeAll()
        
        for item in title {
            items.append(getTitle(title: item))
        }
        tagsCollectionView.reloadData()
        addElements()
    }
    
    private func addElements() {

        addSubview(stackView)
        stackView.addArrangedSubview(tagsCollectionView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tagsCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(110)
        }
    }
    
    func getTitle(title: String) -> String {
        switch title {
        case "surgery":
            return "Общая хирургия"
        case "stomatology":
            return "Стоматология"
        case "gynecology":
            return "Гинекология"
        case "neuro":
            return "Нейрохирургия"
        case "lor":
            return "Отоларингология"
        case "urology":
            return "Урология"
        case "ophthalmology":
            return "Офтальмология"
        case "anesthesiology":
            return "Анестезиология"
        default:
            return ""
        }
    }
}

extension TagsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: TagCollectionViewCell.self, for: indexPath)
        
        cell.configure(title: items[indexPath.row])
        
        return cell
    }
    
}

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let item = items[indexPath.row]
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : MainFont.regular(size: 12)
        ])
        let realSize = CGSize(width: itemSize.width+16, height: 30)
        return realSize
    }

}

protocol FilterTagLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}


class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func tagLayout(collectionViewWidth: CGFloat) {
        let padding = 10
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}

class TagFlowLayout: UICollectionViewFlowLayout {
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [Row]()
        var currentRowY: CGFloat = -1
            
        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 10))
                
                contentHeight += 35
            }
            rows.last?.add(attribute: attribute)
        }
        
        rows.forEach {
            $0.tagLayout(collectionViewWidth: collectionView?.frame.width ?? 0)
        }
        return rows.flatMap { $0.attributes }
    }
    
    override var collectionViewContentSize: CGSize {
        collectionView?.snp.updateConstraints({ (make) in
            make.height.equalTo(contentHeight)
        })
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
}
