//
//  SubcategoriesView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import UIKit
import Combine

final class SubcategoriesView: UIView {
    
    var events = PassthroughSubject<SubcategoriesViewEvents, Never>()
    private var elements: [MainStruct] = []
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var gridLayout: UICollectionViewFlowLayout = {
        
        let numberOfItemsInRow: CGFloat = 2
        
        let sidesOffset: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - sidesOffset*2 - minimumInteritemSpacing*(numberOfItemsInRow-1)) / numberOfItemsInRow
        let cellHeight: CGFloat = 125 //UIScreen.main.bounds.height == 568 ? 332 : cellWidth * 332 / 168
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: sidesOffset, bottom: 10, right: sidesOffset)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = 15
        return layout
    }()
    
    lazy private var mainCollectionView: UICollectionView = {
        let layout = gridLayout
       
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(MainCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {

        addSubview(contentView)
        contentView.addSubview(mainCollectionView)

        makeConstraints()
    }

    private func makeConstraints() {

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }
    
    func configure(elements: [MainStruct]) {
        self.elements = elements

        mainCollectionView.reloadData()
    }

}

extension SubcategoriesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: MainCollectionViewCell.self, for: indexPath)
        cell.configure(item: elements[indexPath.row])

        return cell
    }

    //Анимация нажатия
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//       collectionView.didHighlightRowAt(at: indexPath)
//    }
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//       collectionView.didUnhighlightRowAt(at: indexPath)
//    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        events.send(.cellClicked(elements[indexPath.row].type))
    }

}
