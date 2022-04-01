//
//  InstrumentListViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import Foundation
import Combine

final class InstrumentListViewController<View: InstrumentListView>: BaseViewController<View> {
        
    private var catalopProvider: CatalogProviderProtocol
    private var cancalables = Set<AnyCancellable>()
    private var type: String
    private var isSurgery: Bool
    
    init(catalopProvider: CatalogProviderProtocol, type: String, isMainCategory: Bool) {
        self.isSurgery = isMainCategory
        self.type = type
        self.catalopProvider = catalopProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(type: self.type)
        subscribeForUpdates()
        
        if isSurgery == true {
            catalopProvider.getSurgeryInstrumentsByType(param: getInstrumentsByTypeRequestParams(type: type))
        } else {
            catalopProvider.getInstrumentsByType(param: getInstrumentsByTypeRequestParams(type: type))
        }
        showLoader()
    }
    
    private func configureNavigationBar(type: String) {
        var title = ""
        var subTitle = ""
        switch type {
        case "separating":
            title = "Общая хирургия"
            subTitle = "Разъединяющие"
        case "connecting":
            title = "Общая хирургия"
            subTitle = "Соединяющие"
        case "pushing":
            title = "Общая хирургия"
            subTitle = "Оттесняющие"
        case "holding":
            title = "Общая хирургия"
            subTitle = "Удерживающие"
        case "stabbing":
            title = "Общая хирургия"
            subTitle = "Колющие"
        case "stomatology":
            title = Category.stomatology.getTitle()
        case "gynecology":
            title = Category.gynecology.getTitle()
        case "neuro":
            title = Category.neuro.getTitle()
        case "lor":
            title = Category.lor.getTitle()
        case "urology":
            title = Category.urology.getTitle()
        case "ophthalmology":
            title = Category.ophthalmology.getTitle()
        case "anesthesiology":
            title = Category.anesthesiology.getTitle()
        default:
            title = "Инструменты"
        }
        let titleView = NavigationBarTitle(title: "Тема: " + title, subTitle: "Раздел: " + subTitle)
        navBar.addItem(titleView, toPosition: .title)
    }
    
    private func subscribeForUpdates() {
        catalopProvider.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: CatalogProviderEvent){
        switch event {
        case .error(let error):
            dismissLoader()
            showErrorWithMessage?(error.errorDescription)
        case .errorMessage(let errorMessage):
            dismissLoader()
            guard let message = errorMessage else { return }
            showErrorWithMessage?(message)
        case .dataLoaded(let response):
            dismissLoader()
            guard let data = response.instruments else { return }
            rootView.configure(instruments: data)
        case .success:
            print("****LikeLoaded")
        default:
            break
        }
        
    }
    
    private func onViewEvents(_ Event: InstrumentListViewEvent) {
        switch Event {
        case .setLike(let id):
            catalopProvider.setLike(with: SetLikeRequestParams(instrument_id: String(id), is_surgery: String(isSurgery)))
        case .removeLike(let id):
            catalopProvider.removeLike(with: RemoveLikeRequestParams(instrument_id: String(id), is_surgery: String(isSurgery)))
        }
    }
    
}
