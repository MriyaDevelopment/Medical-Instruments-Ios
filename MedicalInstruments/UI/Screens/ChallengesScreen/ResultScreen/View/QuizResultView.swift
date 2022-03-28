//
//  QuizResultView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 19.03.2022.
//

import UIKit
import Combine

final class QuizResultView: UIView {
    
    let events = PassthroughSubject<MainPageViewEvent, Never>()
    
    private let visibleStateAlpha: CGFloat = 0.2
    
    private var actionBlockBackView: UIButton = {
        let view = UIButton()
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 24)
        label.numberOfLines = 0
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.text = "Ваш результат"
        label.textAlignment = .center
        return label
    }()
    
    private var dificultLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 14)
        label.numberOfLines = 0
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.text = "Уровень: Легкий"
        label.textAlignment = .center
        return label
    }()
    
    private var timerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_timerImage).setColor(BaseColor.hex_5B67CA.uiColor())
        return imageView
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 16)
        label.text = "10:06"
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        return label
    }()
    
    private var circularProgress: CircularProgressBar = {
        let view = CircularProgressBar()
        view.lineWidth = 9
        view.labelSize = 24
        return view
    }()
    
    private var categoriesChips = TagsCollectionView()
    
    
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(BaseColor.hex_FFFFFF.uiColor(), for: .normal)
        button.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var tryAgainButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        button.setTitle("Пройти еще раз", for: .normal)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(visibleStateAlpha)
        
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func present() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = BaseColor.hex_151515.uiColor().withAlphaComponent(self.visibleStateAlpha)
            self.actionBlockBackView.alpha = 1
            self.actionBlockBackView.transform = CGAffineTransform.identity
        }
    }
    
    func configure(quizResult: QuizResult) {
        
        switch quizResult.level {
        case "1":
            dificultLabel.text = "Уровень: Легкий"
        case "2":
            dificultLabel.text = "Уровень: Средний"
        case "3":
            dificultLabel.text = "Уровень: Сложный"
        default:
            break
        }
        
        timerLabel.text = quizResult.time
        
        circularProgress.setProgress(to: (Double(quizResult.number_of_correct_answers) ?? 1)/(Double(quizResult.number_of_questions) ?? 5))
        
        let categories = quizResult.categories.components(separatedBy: ",")
        
        categoriesChips.configure(title: categories)
        
        if Keychain.shared.getUserToken() == nil {
            tryAgainButton.removeFromSuperview()
        }
    }
    
    private func addElements() {
        
        addSubview(actionBlockBackView)
        actionBlockBackView.addSubview(titleLabel)
        actionBlockBackView.addSubview(dificultLabel)
        actionBlockBackView.addSubview(timerImage)
        actionBlockBackView.addSubview(timerLabel)
        actionBlockBackView.addSubview(circularProgress)
        actionBlockBackView.addSubview(categoriesChips)
        actionBlockBackView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(tryAgainButton)
        buttonsStackView.addArrangedSubview(yesButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        actionBlockBackView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        dificultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        timerImage.snp.makeConstraints { (make) in
            make.top.equalTo(dificultLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview().offset(-15)
        }
        
        timerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dificultLabel.snp.bottom).offset(5)
            make.left.equalTo(timerImage.snp.right).offset(5)
        }
        
        circularProgress.snp.makeConstraints { (make) in
            make.top.equalTo(timerLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(160)
        }
        
        categoriesChips.snp.makeConstraints { (make) in
            make.top.equalTo(circularProgress.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(24)
        }
        
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(categoriesChips.snp.bottom).offset(40)
            make.left.right.bottom.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    private func addTarget() {
        tryAgainButton.addTarget(self, action: #selector(tryAgainAction), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(yesClickedAction), for: .touchUpInside)
    }
    
    @objc private func yesClickedAction() {
        events.send(.yesButtonClicked)
    }
    
    @objc private func tryAgainAction() {
        events.send(.noButtonClicked)
    }
}
