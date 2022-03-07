//
//  PrettyAlertController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Combine

final class PrettyAlertViewController<View: PrettyAlertView>: BaseViewController<View> {
    
    private var cancalables = Set<AnyCancellable>()
    
    private var initInfo: PrettyAlertInitialization
    
    init(initInfo: PrettyAlertInitialization) {
        self.initInfo = initInfo
        super.init(nibName: nil, bundle: nil)
        self.navBar.hideView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForUpdates()
        rootView.configure(initInfo: initInfo)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.present()
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: PrettyAlertViewEvent) {
        switch event {
        
        case .buttonClicked(let index):
            guard let action = initInfo.buttons[index].action else {
                closeAlert()
                return
            }
            action()
        }
    }
    
    private func closeAlert() {
        
        UIView.animate(withDuration: 0.2) {
            self.rootView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
