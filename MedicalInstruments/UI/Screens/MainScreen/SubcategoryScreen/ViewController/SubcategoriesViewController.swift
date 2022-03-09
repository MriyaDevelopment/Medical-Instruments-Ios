//
//  SubcategoriesViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import Foundation

final class SubcategoriesViewController<View: SubcategoriesView>: BaseViewController<View> {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        hideNavBar()
    }

    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "подкатегории", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }
}
