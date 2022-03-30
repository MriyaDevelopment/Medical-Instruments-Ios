//
//  View.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Combine

final class MainView: UIView {
    
    var events = PassthroughSubject<MainViewEvent,Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var elements: [MainStruct] = []
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, Ксения!"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        return label
    }()

    private var subscribesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        button.layer.borderWidth = 1
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.setTitle("Оформить подписку", for: .normal)
        return button
    }()

    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Что будем изучать сегодня?"
        label.textAlignment = .left
        return label
    }()
    
    private var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти и начать обучение", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 18)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setImage(AppIcons.getIcon(.i_arrow_right), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
   
    
    private lazy var gridLayout: UICollectionViewFlowLayout = {
        
        let numberOfItemsInRow: CGFloat = 2
        
        let sidesOffset: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - sidesOffset*2 - minimumInteritemSpacing*(numberOfItemsInRow-1)) / numberOfItemsInRow
        let cellHeight: CGFloat = 120 //UIScreen.main.bounds.height == 568 ? 332 : cellWidth * 332 / 168
        
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
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {

        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subscribesButton)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(mainCollectionView)

        makeConstraints()
    }

    private func makeConstraints() {

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(21)
        }

//        subscribesButton.snp.makeConstraints { (make) in
//            make.centerY.equalTo(titleLabel)
//            make.right.equalToSuperview().inset(16)
//        }

        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(21)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
        }
        
        mainCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }

    }
    
    func configureTitle() {
        if Keychain.shared.getUserName() != nil {
            titleLabel.showView()
            authButton.removeFromSuperview()
            titleLabel.text = "Привет, \(Keychain.shared.getUserName() ?? "")!"
        } else {
            titleLabel.hideView()
            contentView.addSubview(authButton)
            authButton.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().inset(21)
            }
        }
    }

    func configure(elements: [MainStruct]) {
        self.elements = elements

        mainCollectionView.reloadData()
    }
    
    private func addTarget() {
        authButton.addTarget(self, action: #selector(authAction), for: .touchUpInside)
    }
    
    @objc func authAction() {
        events.send(.switchToProfile)
    }

}

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
        if indexPath.row == 0 {
            events.send(.firstCellClicked)
        } else {
            events.send(.cellClicked(elements[indexPath.row].type))
        }
    }

}
