//
//  ChangeCategoriesViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import Foundation
import Combine

final class ChangeCategoriesViewController<View: ChangeCategoriesView>: BaseViewController<View> {
        
    private var cancalables = Set<AnyCancellable>()
    var showQuizScreen: VoidClosure?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hideView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.showView()
        super.viewWillDisappear(animated)
    }
    
    private func subscribeForUpdates() {
        rootView.event.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }

    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Выбери категории", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }

    private func onViewEvents(_ event: ChangeCategoriesViewEvent){
        switch event {
        case .nextClicked:
            showQuizScreen?()
        default:
            break
        }
        
    }
    
}
