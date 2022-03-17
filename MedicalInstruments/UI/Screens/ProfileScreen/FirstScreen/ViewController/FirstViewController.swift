//
//  AuthViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import Foundation
import Combine

final class FirstViewController<View: FirstView>: BaseViewController<View> {
        
    private var cancalables = Set<AnyCancellable>()
    var showAuthScreen: VoidClosure?
    var showMainPageProfile: VoidClosure?
    var showRegistrScreen: VoidClosure?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        subscribeForUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Keychain.shared.getUserToken() != nil {
            showMainPageProfile?()
        }
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: FirstVeiwEvents) {
        switch event {
        case .authClicked:
            showAuthScreen?()
        case .regClicked:
            showRegistrScreen?()
        default:
            break
        }
    }

}
