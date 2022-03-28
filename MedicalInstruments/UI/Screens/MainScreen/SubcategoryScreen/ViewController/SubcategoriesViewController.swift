//
//  SubcategoriesViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import Foundation
import Combine

final class SubcategoriesViewController<View: SubcategoriesView>: BaseViewController<View> {
    
    var showInstrumentListScreen: StringAndBoolClosure?
    private var cancalables = Set<AnyCancellable>()
    private var catalogProvider: CatalogProviderProtocol
    private var elements: [MainStruct] = []
    
    init(catalogProvider: CatalogProviderProtocol) {
        self.catalogProvider = catalogProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        subscribeForUpdates()
        
        catalogProvider.getSubCategories()
    }

    private func configureNavigationBar() {
        let titleView = NavigationBarTitle(title: "Общая хирургия", subTitle: "")
        navBar.addItem(titleView, toPosition: .title)
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: SubcategoriesViewEvents){
        switch event {
        case .cellClicked(let type):
            showInstrumentListScreen?(type, true)
        default:
            break
        }
    }
    
    private func onProviderEvents(_ event: CatalogProviderEvent){
        switch event {
        case .error(let error):
            dismissPreloader()
            showErrorWithMessage?(error.errorDescription)
        case .errorMessage(let errorMessage):
            dismissPreloader()
            guard let message = errorMessage else { return }
            showErrorWithMessage?(message)
        case .subCategoriesLoaded(let response):
            dismissPreloader()
            guard let data = response.subcategory else { return }
            configureCollectionView(data: data)
        default:
            break
        }
    }
    
    private func configureCollectionView(data: [MainCategory]){
        
        let category: [CategorySurgery] = [ CategorySurgery.separating,  CategorySurgery.connecting, CategorySurgery.pushing, CategorySurgery.holding, CategorySurgery.stabbing]
        
        for (index, item) in data.enumerated() {
            elements.append(MainStruct.init(id: item.id ?? 0,
                                            backgroundImage: AppIcons.getIcon(.i_surgery_back),
                                            iconImage: category[index].getIcons(),
                                            type: item.type ?? "",
                                            titleText: item.name ?? "",
                                            subtitleText: "Инструментарий: \(String(item.number_of_questions ?? 0))"))
        }
        
        rootView.configure(elements: elements)
    }
    
}
