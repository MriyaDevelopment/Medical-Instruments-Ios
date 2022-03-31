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
    var showRegistrScreen: VoidClosure?
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
        
        showLoader(background: BaseColor.hex_FFFFFF.uiColor(), alfa: 1, presentationStyle: .fullScreen)
        subscribeForUpdates()
        catalogProvider.getCategories()
        hideNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rootView.configureTitle()
        super.viewWillAppear(animated)
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        catalogProvider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: MainViewEvent){
        switch event {
        case .cellClicked(let type):
            showInstrumentList?(type, false)
        case .firstCellClicked:
            showSubcategories?()
        case .switchToProfile:
            showRegistrScreen?()
        default:
            break
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
        case .categoriesLoaded(let response):
            dismissLoader()
            guard let data = response.category else { return }
            configureCollectionView(data: data)
        default:
            break
        }
    }
    
    private func configureCollectionView(data: [MainCategory]){
        
        let category: [Category] = [ Category.surgery, Category.stomatology, Category.gynecology, Category.neuro, Category.lor, Category.urology, Category.ophthalmology, Category.anesthesiology]
        
        elements.removeAll()
        for (index, item) in data.enumerated() {
            elements.append(MainStruct.init(id: item.id ?? 0,
                                            backgroundImage: category[index].getImage(),
                                            iconImage: category[index].getIcons(),
                                            type: item.type ?? "",
                                            titleText: item.name ?? "",
                                            subtitleText: "Инструментарий: \(String(item.number_of_questions ?? 0))"))
        }
        
        rootView.configure(elements: elements)
    }
}
