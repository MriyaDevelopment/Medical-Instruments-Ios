//
//  ChangeDificultView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import UIKit
import Combine

final class ChangeCategoriesView: UIView {
    
    var event = PassthroughSubject<ChangeCategoriesViewEvent, Never>()
    private var types: [Types] = []
    private var currentTypes: [String : String] = [:]
    
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
        button.isUserInteractionEnabled = true
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
        addTarget()
    }
    
    private func makeConstraints() {
        
        nextButton.snp.makeConstraints{ (make) in
            make.bottom.right.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints{ (make) in
            make.left.right.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(nextButton.snp.top).inset(10)
        }
    }
    
    func configure(types: [Types]) {
        self.types = types
        
        tableView.reloadData()
    }
    
    private func addTarget(){
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @objc func nextAction(){
        
        let typesDictionary = currentTypes.keys
        var typeString = ""
        for item in typesDictionary {
            typeString.append("\(item),")
        }
        if typesDictionary.isEmpty {
            nextButton.shake()
        } else {
            event.send(.nextClicked(String(typeString.dropLast())))
        }
    }
    
    private func removeType(name: String) {
        currentTypes.removeValue(forKey: name)
    }
    
    private func addType(name: String) {
        currentTypes[name] = name
    }
    
}

extension ChangeCategoriesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: ChangeCategoriesCell.self, for: indexPath)
        cell.configure(type: types[indexPath.row])
        cell.removeType = { [weak self] name in self?.removeType(name: name)}
        cell.addType = { [weak self] name in self?.addType(name: name)}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
}
