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
        return stackView
    }()
    
    lazy private var layout: TagsLayout = {
        let layout = TagsLayout()
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
        addElements()
        layout.delegate = self
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
            make.height.equalTo(100)
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


class TagsLayout: UICollectionViewFlowLayout {
    
    weak var delegate: UICollectionViewDelegateFlowLayout?
    
    // 2
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 10
    private var lineSpacing: CGFloat = 10
    
    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 4
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        
        guard
            cache.isEmpty,
            let collectionView = collectionView
        else {
            return
        }
        
        var x: CGFloat = sectionInset.left
        var y: CGFloat = sectionInset.top
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            guard let itemSize = delegate?.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) else { return }
            
            if x + itemSize.width > contentWidth {
                x = sectionInset.left
                y = y + itemSize.height + lineSpacing
            }
            
            let frame = CGRect(x: x,
                               y: y,
                               width: itemSize.width,
                               height: itemSize.height)
            
            x = x + itemSize.width + cellPadding
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
        }
    }
    
    // 5
    override var collectionViewContentSize: CGSize {
        collectionView?.snp.updateConstraints({ (make) in
            make.height.equalTo(contentHeight)
        })
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      // Loop through the cache and look for items in the rect
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
}
