//
//  ProfileView.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import Combine

final class ProfileView: UIView {
    
    var event = PassthroughSubject<MainPageViewEvent, Never>()
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 14)
        button.setTitleColor(BaseColor.hex_232324.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        button.setImage(AppIcons.getIcon(.i_logout), for: .normal)
        button.imageEdgeInsets.left = -9
        return button
    }()
    
    private var subscribesLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.text = "💎 Подписка оформлена"
        return label
    }()
    
    private var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        imageView.layer.cornerRadius = 60
        imageView.image = AppIcons.getIcon(.i_user_avatar)
        imageView.contentMode = .center
        imageView.backgroundColor = .white
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 20)
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.text = "Ксения"
        return label
    }()
    
    private var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "aovseenk@gmail.com"
        return label
    }()
    
    lazy private var lastResultView: LastresultView = {
        let view = LastresultView()
        view.tryAgainClicked = { [weak self] in self?.event.send(.tryAgainClicked)}
        return view
    }()
    
    lazy private var firstBanner: FirsBannerView = {
        let view = FirsBannerView()
        view.startTestButttonClicked = { [weak self] in self?.event.send(.switchToTestClicked) }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBanner(data: GetResultResponse) {
        guard let levels = data.levels else {return}
        lastResultView.hideView()
        firstBanner.hideView()
        
        if levels.isEmpty {
            firstBanner.showView()
        } else {
            lastResultView.showView()
            guard let lastData = data.levels?.first else {return}
            configureLastResult(data: lastData)
        }
    }
    
    func configureLastResult(data: GetResultData) {
        lastResultView.configure(data: data)
    }
    
    func configureProfile(data: User) {
        
        if data.is_subscribed == false {
            subscribesLabel.hideView()
        }
        
        userNameLabel.text = data.name
        userEmailLabel.text = data.email
    }
    
    func removeElements() {
        lastResultView.removeFromSuperview()
        
        addElements()
        
        contentView.addSubview(lastResultView)
        
        lastResultView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(userEmailLabel.snp.bottom).offset(15)
        }

    }
    
    private func addElements() {
        
        addSubview(contentView)
        contentView.addSubview(exitButton)
        contentView.addSubview(subscribesLabel)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userEmailLabel)
        contentView.addSubview(lastResultView)
        contentView.addSubview(firstBanner)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        exitButton.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(20)
        }
        
        userImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(130)
            make.width.height.equalTo(120)
        }
        
        subscribesLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(userImageView.snp.top).offset(-13)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImageView.snp.bottom).offset(16)
        }
        
        userEmailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
        }
        
        lastResultView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(userEmailLabel.snp.bottom).offset(15)
        }
        
        firstBanner.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(userEmailLabel.snp.bottom).offset(15)
        }
    }
    
    private func addTarget(){
        exitButton.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    @objc func exitAction(){
        event.send(.exitClicked)
    }
}
