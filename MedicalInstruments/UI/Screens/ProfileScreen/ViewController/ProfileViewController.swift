//
//  ProfileViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation


final class ProfileViewController<View: ProfileView>: BaseViewController<View> {
    
    private var items = ["Общая хирургия","Акушерство и гинекология","Стоматология"]
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        
        rootView.configureTags(items: items)
    }

}
