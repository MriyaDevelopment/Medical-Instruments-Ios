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
    var showQuizScreen: BoolClosure?
    
    private var cancalables = Set<AnyCancellable>()
    private let catalogProvider: CatalogProviderProtocol
    
    init(id: Int = 1, types: String = "lor", catalogProvider: CatalogProviderProtocol, isLastTest: Bool = false) {
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
        configureNavigationBar(index: id)
        showLoader(background: .white, alfa: 1)
        if isLastTest == false {
            catalogProvider.getQuestionByTypeAndLevel(with: getQuestionByTypeAndLevelRequestParams(type: types, level: String(id)))
        } else {
            catalogProvider.getLastTest()
        }
        subscribeForUpdates()
        startTimer()
        
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
    
    private func configureNavigationBar(index: Int) {
        navBar.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        let button = UIButton()
        let image = AppIcons.getIcon(.i_back_button).withTintColor(.white)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backActn), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
        }
        navBar.addItem(button, toPosition: .leftSide)
        
        let titleView = NavigationBarTitle(title: configureTitle(index: index), subTitle: "")
        titleView.titleLabel.textColor = .white
        navBar.addItem(titleView, toPosition: .title)
    }
    
    @objc private func backActn() {
        backActionClosure()
    }
    
    private func configureTitle(index: Int) -> String {
        switch index {
        case 1:
            return "Уровень сложности: Легкий"
        case 2:
            return "Уровень сложности: Средний"
        case 3:
            return "Уровень сложности: Сложный"
        default:
            return ""
        }
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
//                #warning("заглушка, необходимо достать все типы и удалить повторяющиеся")
                types = getTypes(questions: questions)
                print("****\(getTypes(questions: questions))")
            }
        default:
            break
        }
    }
    
    private func getTypes(questions: [Questions]) -> String {
        var string = ""
        for question in questions {
            string.append((question.type ?? "") + " ")
        }
    
        let stringArray = string.dropLast().components(separatedBy: " ")
        let filteredArray = Array(NSOrderedSet(array: stringArray))
        var types = ""
        for item in filteredArray {
            types.append(item as! String + ",")
        }
        let result = types.dropLast()
        return String(result)
    }
    
    private func onViewEvents(_ event: QuizViewEvents) {
        switch event {
        case .finishQuiz:
            if Keychain.shared.getUserToken() != nil {
            catalogProvider.setResult(with: SetResultRequestParams(level: String(id),
                                                                   categories: types,
                                                                   number_of_correct_answers: String(rootView.correctCount),
                                                                   number_of_questions: String(numberOfQuest),
                                                                   questions: String(questionsString.dropLast())))
            } else {
                let quizResult = QuizResult.init(time: ("\(minutes):\(seconds)"),
                                                 level: String(id),
                                                 categories: types,
                                                 number_of_correct_answers: String(rootView.correctCount),
                                                 number_of_questions: String(numberOfQuest))
                showResultScreen(quizResult: quizResult)
            }
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
        controller.tryAgainClicked = { [weak self] in self?.tryAgain() }
        present(controller, animated: true, completion: nil)
    }
    
    private func tryAgain() {
        minutes = 0
        seconds = 0
        startTimer()
        rootView.reloadData()
        catalogProvider.getLastTest()
    }
    
}
