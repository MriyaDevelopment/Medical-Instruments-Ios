//
//  ResultScreenViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 19.03.2022.
//

import UIKit
import Combine

final class QuizResultViewController<View: QuizResultView>: BaseViewController<View> {
    
    private var cancalables = Set<AnyCancellable>()
    var okClicked: VoidClosure?

    private var quizResult: QuizResult
    
    init(quizResult: QuizResult) {
        self.quizResult = quizResult
        super.init(nibName: nil, bundle: nil)
        self.navBar.hideView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForUpdates()
        rootView.configure(quizResult: quizResult)
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
            closeAlert()
            okClicked?()
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
