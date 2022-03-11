//
//  ChallengesView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Combine

final class ChallengesView: UIView {
    
    var events = PassthroughSubject<ChalengesViewEvent, Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 18)
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.text = "Проверь свои знания"
        label.textAlignment = .left
        return label
    }()
    
    private var changeDificultLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Выбери подходящий уровень сложности"
        label.textAlignment = .left
        return label
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DuficultTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
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
        
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(changeDificultLabel)
        contentView.addSubview(tableView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview().inset(16)
        }
        
        changeDificultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(changeDificultLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ChallengesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: DuficultTableViewCell.self, for: indexPath)
        cell.configure(index: indexPath.row)
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        events.send(.cellClicked)
    }
}
