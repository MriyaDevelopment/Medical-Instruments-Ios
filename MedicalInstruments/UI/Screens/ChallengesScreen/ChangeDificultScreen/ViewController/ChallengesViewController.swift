//
//  ChallengesViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation
import Combine

final class ChallengesViewController<View: ChallengesView>: BaseViewController<View> {
        
    var showChangeCategoriesScreen: IntClosure?
    private var cancalables = Set<AnyCancellable>()
    
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

    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: ChalengesViewEvent){
        switch event {
        case .cellClicked(let id):
            showChangeCategoriesScreen?(id)
        default:
            break
        }
        
    }
}
