//
//  QuizViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 13.03.2022.
//

import UIKit
import Combine

final class QuizViewController<View: QuizView>: BaseViewController<View> {
        
    private var types: String
    private var id: Int
    private var isLastTest: Bool
    
    private var numberOfQuest = 0
    private var questionsString = ""
    
    var minutes = 0
    var seconds = 0
    var timer = Timer()
    
    var showRootScreen: VoidClosure?
    
    private var cancalables = Set<AnyCancellable>()
    private let catalogProvider: CatalogProviderProtocol
    
    init(id: Int = 0, types: String = "", catalogProvider: CatalogProviderProtocol, isLastTest: Bool = false) {
        self.types = types
        self.id = id
        self.catalogProvider = catalogProvider
        self.isLastTest = isLastTest
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        showLoader(background: .white, alfa: 1)
        if isLastTest == false {
            catalogProvider.getQuestionByTypeAndLevel(with: getQuestionByTypeAndLevelRequestParams(type: types, level: String(id)))
        } else {
            catalogProvider.getLastTest()
        }
        subscribeForUpdates()
        startTimer()
        
        print("****\(types)")
    }
    
    private func subscribeForUpdates() {
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hideView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
        tabBarController?.tabBar.showView()
        super.viewWillDisappear(animated)
    }
    
    private func configureNavigationBar() {
        navBar.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        let button = UIButton()
        let image = AppIcons.getIcon(.i_back_button).setColor(BaseColor.hex_FFFFFF.uiColor())
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backActn), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
        }
        navBar.addItem(button, toPosition: .leftSide)
        
        let titleView = NavigationBarTitle(title: "Уровень сложности: Сложный", subTitle: "")
        titleView.titleLabel.textColor = .white
        navBar.addItem(titleView, toPosition: .title)
    }
    
    @objc private func backActn() {
        backActionClosure()
    }
    
    private func onProviderEvents(_ event: CatalogProviderEvent){
        switch event {
        case .error(let error):
            dismissLoader()
            showErrorWithMessage?(error.errorDescription)
        case .errorMessage(let errorMessage):
            dismissLoader()
            guard let message = errorMessage else { return }
            showErrorWithMessage?(message)
        case .questionsLoaded(let response):
            dismissLoader()
            guard let questions = response.questions else { return }
            if !questions.isEmpty {
                rootView.configure(questions: questions)
                self.numberOfQuest = questions.count
                for item in questions {
                    questionsString += "\(item.id ?? 0),"
                }
            }
        case .setResultDone(let response):
            
            guard let result = response.data else { return }
            
            let quizResult = QuizResult.init(time: ("\(minutes):\(seconds)"),
                                             level: result.level ?? "",
                                             categories: result.categories ?? "",
                                             number_of_correct_answers: result.number_of_correct_answers ?? "",
                                             number_of_questions: result.number_of_questions ?? "")
            showResultScreen(quizResult: quizResult)
            
            stopTimer()
        case .lastTestLoaded(let response):
            dismissLoader()
            guard let questions = response.questions else { return }
            if !questions.isEmpty {
                rootView.configure(questions: questions)
                self.numberOfQuest = questions.count
                questionsString = ""
                for item in questions {
                    questionsString += "\(item.id ?? 0),"
                }
            }
        default:
            break
        }
    }
    
    private func onViewEvents(_ event: QuizViewEvents) {
        switch event {
        case .finishQuiz:
            catalogProvider.setResult(with: SetResultRequestParams(level: String(id),
                                                                   categories: types,
                                                                   number_of_correct_answers: String(rootView.correctCount),
                                                                   number_of_questions: String(numberOfQuest),
                                                                   questions: questionsString))
        }
    }
    
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    @objc func timerAction() {
        if seconds < 59 {
            seconds += 1
            rootView.setTimer(min: minutes, sec: seconds)
        }
        else {
            seconds = 0
            minutes += 1
            rootView.setTimer(min: minutes, sec: seconds)
        }
    }
    
    private func showResultScreen(quizResult: QuizResult) {
        let controller = QuizResultViewController(quizResult: quizResult)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.okClicked = { [weak self] in self?.showRootScreen?() }
        present(controller, animated: true, completion: nil)
    }
    
}
