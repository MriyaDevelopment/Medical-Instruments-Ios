//
//  FavouritesView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//
import UIKit
import Combine

final class FavouritesView: UIView {
    
    private var instruments: [Instruments] = []
    var events = PassthroughSubject<FavouritesViewEvent, Never>()
    
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
    
    private let emptyView = EmptyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(instruments: [Instruments]) {
        if instruments.count > 0 {
            emptyView.hideView()
            instrumentTableView.showView()
        } else {
            emptyView.showView()
            instrumentTableView.hideView()
        }
        self.instruments = instruments
        instrumentTableView.reloadData()
    }
    
    private func addElements() {
        addSubview(contentView)
        contentView.addSubview(instrumentTableView)
        contentView.addSubview(emptyView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        instrumentTableView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}

extension FavouritesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instruments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withType: InstrumentTableViewCell.self, for: indexPath)
        cell.configure(data: instruments[indexPath.row])
        cell.likeDisableClicked = { [weak self] in self?.events.send(.removeLike(self?.instruments[indexPath.row].id ?? 0,  self?.instruments[indexPath.row].is_surgery ?? false))}
        cell.likeEnableClicked = { [weak self] in self?.events.send(.setLike(self?.instruments[indexPath.row].id ?? 0, self?.instruments[indexPath.row].is_surgery ?? false))}
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
}
