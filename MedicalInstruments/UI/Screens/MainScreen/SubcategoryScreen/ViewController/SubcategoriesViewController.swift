//
//  SubcategoriesViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import Foundation
import Combine

final class SubcategoriesViewController<View: SubcategoriesView>: BaseViewController<View> {
    
    var showInstrumentListScreen: VoidClosure?
    private var cancalables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        subscribeForUpdates()
    }

    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "подкатегории", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: SubcategoriesViewEvents){
        switch event {
        case .cellClicked(let index):
            showInstrumentListScreen?()
        default:
            break
        }
        
    }
}