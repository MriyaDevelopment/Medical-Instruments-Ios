//
//  QuizVeiw.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 13.03.2022.
//

import UIKit

final class QuizView: UIView {
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_backgroundImage)
        return imageView
    }()
    
    private var countChalengesLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 16)
        label.text = "Задание: 10/35"
        label.textColor = BaseColor.hex_FFFFFF.uiColor()
        return label
    }()
    
    private var timerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_timerImage)
        return imageView
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 16)
        label.text = "10:06"
        label.textColor = BaseColor.hex_FFFFFF.uiColor()
        return label
    }()
    
    private var progressBar: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = BaseColor.hex_FFFFFF.uiColor()
        view.trackTintColor = BaseColor.hex_FFFFFF.uiColor().withAlphaComponent(0.25)
        view.setProgress((10/35), animated: true)
        return view
    }()
    
    private var instrumentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        imageView.layer.cornerRadius = 20
        imageView.image = AppIcons.getIcon(.i_default_image)
        imageView.contentMode = .center
        imageView.backgroundColor = .white
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var firstAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Лигатурная игла Дешана", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 12)
        button.setTitleColor(BaseColor.hex_232324.uiColor(), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        return button
    }()
    
    private var secondAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(BaseColor.hex_232324.uiColor(), for: .normal)
        button.setTitle("Лигатурная игла Дешана", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 12)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        return button
    }()
    
    private var thirdAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(BaseColor.hex_232324.uiColor(), for: .normal)
        button.setTitle("Лигатурная игла Дешана", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 12)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        return button
    }()
    
    private var fourthAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(BaseColor.hex_232324.uiColor(), for: .normal)
        button.setTitle("Лигатурная", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 12)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        return button
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Следующий вопрос", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 16)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setImage(AppIcons.getIcon(.i_back_button), for: .normal)
        button.imageEdgeInsets.left = -9
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        
        addSubview(contentView)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(countChalengesLabel)
        contentView.addSubview(timerImage)
        contentView.addSubview(timerLabel)
        contentView.addSubview(progressBar)
        contentView.addSubview(instrumentImageView)
        contentView.addSubview(firstStackView)
        firstStackView.addArrangedSubview(firstAnswerButton)
        firstStackView.addArrangedSubview(secondAnswerButton)
        contentView.addSubview(secondStackView)
        secondStackView.addArrangedSubview(thirdAnswerButton)
        secondStackView.addArrangedSubview(fourthAnswerButton)
        
        contentView.addSubview(nextButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints{ (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        backgroundImage.snp.makeConstraints{ (make) in
            make.top.left.right.equalToSuperview()
        }
        
        countChalengesLabel.snp.makeConstraints{ (make) in
            make.top.left.equalToSuperview().inset(20)
        }
        
        timerLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(countChalengesLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        timerImage.snp.makeConstraints{ (make) in
            make.centerY.equalTo(countChalengesLabel)
            make.right.equalTo(timerLabel.snp.left).offset(-10)
        }
        
        progressBar.snp.makeConstraints{ (make) in
            make.top.equalTo(countChalengesLabel.snp.bottom).offset(10)
            make.height.equalTo(8)
            make.right.left.equalToSuperview().inset(16)
        }
        
        instrumentImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(progressBar.snp.bottom).offset(20)
            make.height.equalTo(300)
            make.right.left.equalToSuperview().inset(16)
        }
        
        firstStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(instrumentImageView.snp.bottom).offset(20)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(51)
        }
        
        secondStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(firstStackView.snp.bottom).offset(16)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(51)
        }
        
        firstAnswerButton.snp.makeConstraints{ (make) in
            make.width.equalToSuperview().multipliedBy(0.48)
        }
        
        secondAnswerButton.snp.makeConstraints{ (make) in
            make.width.equalToSuperview().multipliedBy(0.48)
        }
        
        thirdAnswerButton.snp.makeConstraints{ (make) in
            make.width.equalToSuperview().multipliedBy(0.48)
        }
        
        fourthAnswerButton.snp.makeConstraints{ (make) in
            make.width.equalToSuperview().multipliedBy(0.48)
        }
        
        nextButton.snp.makeConstraints{ (make) in
            make.right.bottom.equalToSuperview().inset(16)
        }
    }
}
