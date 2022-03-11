//
//  InstrumentListViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import Foundation


final class InstrumentListViewController<View: InstrumentListView>: BaseViewController<View> {
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Тема: Общая хирургия", subTitle: "Раздел: Соединяющие")
        navBar.addItem(titleView, toPosition: .title)
    }
    
}
