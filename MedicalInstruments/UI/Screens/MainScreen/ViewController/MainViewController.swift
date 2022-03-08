//
//  MainViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation


final class MainViewController<View: MainView>: BaseViewController<View> {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }

    private func configureCollectionView(){
        var elements: [MainStruct] = []
        elements.append(MainStruct.init(id: 1,
                                        backgroundImage: AppIcons.getIcon(.i_default_image),
                                        iconImage: AppIcons.getIcon(.i_default_image),
                                        titleText: "Общая хирургия",
                                        subtitleText: "Инструментарий: 40"))
        elements.append(MainStruct.init(id: 2,
                                        backgroundImage: AppIcons.getIcon(.i_default_image),
                                        iconImage: AppIcons.getIcon(.i_default_image),
                                        titleText: "Стоматология",
                                        subtitleText: "Инструментарий: 40"))
        elements.append(MainStruct.init(id: 3,
                                        backgroundImage: AppIcons.getIcon(.i_default_image),
                                        iconImage: AppIcons.getIcon(.i_default_image),
                                        titleText: "Акушерство и гинекология",
                                        subtitleText: "Инструментарий: 40"))
        elements.append(MainStruct.init(id: 4,
                                        backgroundImage: AppIcons.getIcon(.i_default_image),
                                        iconImage: AppIcons.getIcon(.i_default_image),
                                        titleText: "Нейрохирургия",
                                        subtitleText: "Инструментарий: 40"))
        elements.append(MainStruct.init(id: 5,
                                        backgroundImage: AppIcons.getIcon(.i_default_image),
                                        iconImage: AppIcons.getIcon(.i_default_image),
                                        titleText: "Офтальмология",
                                        subtitleText: "Инструментарий: 40"))
        elements.append(MainStruct.init(id: 6,
                                        backgroundImage: AppIcons.getIcon(.i_default_image),
                                        iconImage: AppIcons.getIcon(.i_default_image),
                                        titleText: "Оториноларингология",
                                        subtitleText: "Инструментарий: 40"))

//        rootView.configure(elements: elements)
    }
}
