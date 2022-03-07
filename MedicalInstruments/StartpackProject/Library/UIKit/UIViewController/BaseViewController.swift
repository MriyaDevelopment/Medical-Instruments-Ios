//
//  BaseViewController.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import SnapKit
import FloatingPanel

class BaseViewController<View: UIView>: UIViewController, UIGestureRecognizerDelegate, FloatingPanelControllerDelegate {
    
    var showErrorWithMessage: StringClosure?
    
    var rootView: View { view as! View }
    let navBar = NavigationBar()
    var isOnScreen: Bool = false
    private var preloader: UIActivityIndicatorView?
    private var loaderViewController: UIViewController?

    lazy var backActionClosure: () -> Void = { [weak self] in self?.navigationController?.popViewController(animated: true) }
    
    override func loadView() {
        view = View()
        
        view.addTapGestureToHideKeyboard()
        
        navBar.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        if ( self != self.navigationController?.viewControllers[0] )
        {
         
            let button = UIButton()
            let image = AppIcons.getIcon(.i_back_button)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            button.snp.makeConstraints { (make) in
                make.width.height.equalTo(24)
            }
            navBar.addItem(button, toPosition: .leftSide)
        }
        
        showErrorWithMessage = { [weak self] message in
            
            let initInfo = PrettyAlertInitialization(title: "Ошибка", message: message, buttons:
                                                        [
                                                            ButtonInfo(title: "ОК", type: .action, action: nil)
                                                        ])
            self?.showCustomAlertController(initInfo: initInfo)
        }
    }
    
    @objc private func backAction() {
        backActionClosure()
    }
    
    func hideNavBar() {
        navBar.isHidden = true
        self.additionalSafeAreaInsets.top = 0
    }
    
    func showPreloader() {
        preloader = UIActivityIndicatorView()
        guard let preloader = self.preloader else { return }
        rootView.addSubview(preloader)
        preloader.snp.makeConstraints { (make) in
            make.center.equalTo(rootView.safeAreaLayoutGuide.snp.center)
        }
        preloader.startAnimating()
    }
    
    func dismissPreloader() {
        guard let preloader = self.preloader else { return }
        preloader.stopAnimating()
        preloader.snp.removeConstraints()
        preloader.removeFromSuperview()
    }
    
    func showLoader(background: UIColor = BaseColor.hex_BEBEBE.uiColor(), alfa: CGFloat = 0.6, presentationStyle: UIModalPresentationStyle = .overFullScreen) {
        
        let loader = UIActivityIndicatorView()
        
        loaderViewController = UIViewController()
        guard let loaderViewController = self.loaderViewController else { return }
        
        loaderViewController.modalPresentationStyle = presentationStyle
        loaderViewController.view.backgroundColor = background
        loaderViewController.view.alpha = alfa
        loaderViewController.view.addSubview(loader)
    
        loader.snp.makeConstraints { (make) in
            make.center.equalTo(loaderViewController.view.snp.center)
        }

        loader.startAnimating()

        self.present(loaderViewController, animated: false, completion: nil)
    }
    
    func dismissLoader() {
        guard let loaderViewController = self.loaderViewController else { return }
        loaderViewController.dismiss(animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.setBackButtonImage()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.additionalSafeAreaInsets.top = 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isOnScreen = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isOnScreen = false
    }
    
    private func showCustomAlertController(initInfo: PrettyAlertInitialization) {
        let vc = PrettyAlertViewController(initInfo: initInfo)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    private func getErrorAlert(messege: String?) -> UIAlertController {
        let inputData = UIAlertControllerCommonInputData(
            title: "Ошибка",
            message: messege,
            buttons: [
                .init(title: "OK")
            ])
        return .init(inputData: inputData)
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, animatorForPresentingTo state: FloatingPanelState) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.35, curve: .easeOut)
    }

    func floatingPanel(_ fpc: FloatingPanelController, animatorForDismissingWith velocity: CGVector) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.35, curve: .easeOut)
    }
}
