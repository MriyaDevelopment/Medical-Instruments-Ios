//
//  LaunchScreenViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation


final class LaunchScreenViewController<View: LaunchScreenView>: BaseViewController<View> {
    
    var preparationFinished: VoidClosure?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.hideView()
        preparationFinished?()
    }

}
