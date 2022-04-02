//
//  InstrumentListView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//


import UIKit
import Combine

final class InstrumentListView: UIView {
    
    private var instruments: [Instruments] = []
    var events = PassthroughSubject<InstrumentListViewEvent, Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy private var instrumentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InstrumentTableViewCell.self)
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
        contentView.addSubview(instrumentTableView)
        
        makeConstraints()
    }
    
    func configure(instruments: [Instruments]){
        self.instruments = instruments
        
        instrumentTableView.reloadData()
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        instrumentTableView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}

extension InstrumentListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instruments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: InstrumentTableViewCell.self, for: indexPath)
        cell.configure(data: instruments[indexPath.row])
        cell.contentView.isUserInteractionEnabled = false
        cell.likeDisableClicked = { [weak self] in self?.events.send(.removeLike(self?.instruments[indexPath.row].id ?? 0))}
        cell.likeEnableClicked = { [weak self] in self?.events.send(.setLike(self?.instruments[indexPath.row].id ?? 0))}
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
}

