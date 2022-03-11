//
//  ChangeDificultView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import UIKit

final class ChangeCategoriesView: UIView {
    
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChangeCategoriesCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 16)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setImage(AppIcons.getIcon(.i_back_button), for: .normal)
        button.imageEdgeInsets.left = 165
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(tableView)
        
        addSubview(nextButton)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        nextButton.snp.makeConstraints{ (make) in
            make.bottom.right.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints{ (make) in
            make.left.right.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(nextButton.snp.top).inset(10)
        }
        
    }
}

extension ChangeCategoriesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: ChangeCategoriesCell.self, for: indexPath)
//        cell.configure(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
