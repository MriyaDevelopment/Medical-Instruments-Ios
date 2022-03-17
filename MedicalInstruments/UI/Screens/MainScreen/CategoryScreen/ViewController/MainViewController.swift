//
//  MainViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation
import Combine

final class MainViewController<View: MainView>: BaseViewController<View> {
    
    private var cancalables = Set<AnyCancellable>()
    var showSubcategories: VoidClosure?
    var showInstrumentList: StringAndBoolClosure?
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
        
        showPreloader()
        subscribeForUpdates()
        hideNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        catalogProvider.getCategories()
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: MainViewEvent){
        switch event {
        case .cellClicked(let type):
            showInstrumentList?(type, true)
        case .firstCellClicked:
            showSubcategories?()
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
        case .categoriesLoaded(let response):
            dismissPreloader()
            guard let data = response.category else { return }
            configureCollectionView(data: data)
        default:
            break
        }
    }
    
    private func configureCollectionView(data: [MainCategory]){
        
        let backImages = [AppIcons.getIcon(.i_surgery_back), AppIcons.getIcon(.i_dentistry), AppIcons.getIcon(.i_AiG),  AppIcons.getIcon(.i_neurosurgery), AppIcons.getIcon(.i_ophthalmology),AppIcons.getIcon(.i_otorhinolaryngology),AppIcons.getIcon(.i_otorhinolaryngology),AppIcons.getIcon(.i_otorhinolaryngology),AppIcons.getIcon(.i_otorhinolaryngology),AppIcons.getIcon(.i_otorhinolaryngology)]
        elements.removeAll()
        for (index, item) in data.enumerated() {
            elements.append(MainStruct.init(id: item.id ?? 0,
                                            backgroundImage: backImages[index],
                                            iconImage: AppIcons.getIcon(.i_default_image),
                                            type: item.type ?? "",
                                            titleText: item.name ?? "",
                                            subtitleText: "Инструментарий: \(String(item.number_of_questions ?? 0))"))
        }
        
        rootView.configure(elements: elements)
    }
}
