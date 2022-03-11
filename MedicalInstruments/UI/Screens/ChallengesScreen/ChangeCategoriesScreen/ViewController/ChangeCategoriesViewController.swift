//
//  ChangeCategoriesViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import Foundation

final class ChangeCategoriesViewController<View: ChangeCategoriesView>: BaseViewController<View> {
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hideView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.showView()
        super.viewWillDisappear(animated)
    }

    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Выбери категории", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }

}
