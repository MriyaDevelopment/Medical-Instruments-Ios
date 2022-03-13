//
//  QuizViewController.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 13.03.2022.
//

import UIKit

final class QuizViewController<View: QuizView>: BaseViewController<View> {
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
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
}
