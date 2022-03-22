//
//  AlertDialogViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 15.03.2022.
//

import UIKit
import Combine

final class AlertDialogViewController<View: AlertDialogView>: BaseViewController<View> {
    
    private var cancalables = Set<AnyCancellable>()
    var yesClicked: VoidClosure?

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navBar.hideView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForUpdates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.present()
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: MainPageViewEvent) {
        switch event {
        case .noButtonClicked:
            closeAlert()
        case .yesButtonClicked:
            Keychain.shared.deleteUserToken()
            closeAlert()
            yesClicked?()
        default:
            break
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
