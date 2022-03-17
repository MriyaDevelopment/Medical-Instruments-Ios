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
    
    private var cancalables = Set<AnyCancellable>()
    private let catalogProvider: CatalogProviderProtocol
    
    init(id: Int, types: String, catalogProvider: CatalogProviderProtocol) {
        self.types = types
        self.id = id
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        showLoader(background: .white, alfa: 1)
        catalogProvider.getQuestionByTypeAndLevel(with: getQuestionByTypeAndLevelRequestParams(type: types, level: String(id)))
        subscribeForUpdates()
    }
    
    private func subscribeForUpdates() {
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hideView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
            }
        default:
            break
        }
        
    }
}
