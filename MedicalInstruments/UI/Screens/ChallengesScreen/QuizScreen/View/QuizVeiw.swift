//
//  QuizVeiw.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 13.03.2022.
//

import UIKit

final class QuizView: UIView {
    
    private var questions: [Questions] = []
    private var currentQuestion = 0
    private var correctAnswer = ""
    private var firstQuestion = true
    
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
        view.setProgress(1, animated: true)
        return view
    }()
    
    private var imageContainer: UIView = {
        let view = UIView()
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.clipsToBounds = false
        return view
    }()
    
    private var instrumentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppIcons.getIcon(.i_default_image)
        imageView.contentMode = .scaleAspectFit
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
        button.titleLabel?.numberOfLines = 0
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
        button.titleLabel?.numberOfLines = 0
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
        button.titleLabel?.numberOfLines = 0
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
        button.titleLabel?.numberOfLines = 0
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
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(questions: [Questions]) {
        self.questions = questions
        configureQuestion(question: questions[currentQuestion])
    }
    
    func configureQuestion(question: Questions) {
        countChalengesLabel.text = ("\(currentQuestion + 1) / \(questions.count)")
        
        progressBar.setProgress(( Float(currentQuestion + 1) / Float(questions.count)), animated: true)
        instrumentImageView.loadImage(by: question.question ?? "")
        
        firstAnswerButton.setTitle(question.answer_one, for: .normal)
        secondAnswerButton.setTitle(question.answer_two, for: .normal)
        thirdAnswerButton.setTitle(question.answer_three, for: .normal)
        fourthAnswerButton.setTitle(question.answer_four, for: .normal)
        
        correctAnswer = question.true_answer ?? ""
    }
    
    private func addElements() {
        
        addSubview(contentView)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(countChalengesLabel)
        contentView.addSubview(timerImage)
        contentView.addSubview(timerLabel)
        contentView.addSubview(progressBar)
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(instrumentImageView)
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
        
        imageContainer.snp.makeConstraints{ (make) in
            make.top.equalTo(progressBar.snp.bottom).offset(20)
            make.height.equalTo(300)
            make.right.left.equalToSuperview().inset(16)
        }
        
        instrumentImageView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview().inset(9)
        }
        
        firstStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(instrumentImageView.snp.bottom).offset(30)
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
    
    private func addTarget() {
        firstAnswerButton.addTarget(self, action: #selector(firstClicked), for: .touchUpInside)
        secondAnswerButton.addTarget(self, action: #selector(secondClicked), for: .touchUpInside)
        thirdAnswerButton.addTarget(self, action: #selector(thirdClicked), for: .touchUpInside)
        fourthAnswerButton.addTarget(self, action: #selector(fourthClicked), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @objc func nextAction() {
        setDefaultButton()
        if firstQuestion {
            firstQuestion = false
            currentQuestion += 1
            configureQuestion(question: questions[currentQuestion])
            currentQuestion += 1
        } else if currentQuestion < questions.count {
            configureQuestion(question: questions[currentQuestion])
            currentQuestion += 1
            if currentQuestion == questions.count {
                nextButton.setTitle("Завершить тестирование", for: .normal)
            }
        }
    }
    
    @objc func firstClicked () {
        disableButton()
        if firstAnswerButton.titleLabel?.text == correctAnswer {
            firstAnswerButton.flash()
            firstAnswerButton.backgroundColor = BaseColor.hex_81E89E.uiColor().withAlphaComponent(0.25)
            firstAnswerButton.layer.borderColor = BaseColor.hex_81E89E.cgColor()
            firstAnswerButton.layer.borderWidth = 2
        } else {
            firstAnswerButton.shake()
            firstAnswerButton.backgroundColor = BaseColor.hex_E77D7D.uiColor().withAlphaComponent(0.25)
            firstAnswerButton.layer.borderColor = BaseColor.hex_E77D7D.cgColor()
            firstAnswerButton.layer.borderWidth = 2
        }
    }
    
    @objc func secondClicked () {
        disableButton()
        if secondAnswerButton.titleLabel?.text == correctAnswer {
            secondAnswerButton.flash()
            secondAnswerButton.backgroundColor = BaseColor.hex_81E89E.uiColor().withAlphaComponent(0.25)
            secondAnswerButton.layer.borderColor = BaseColor.hex_81E89E.cgColor()
            secondAnswerButton.layer.borderWidth = 2
        } else {
            secondAnswerButton.shake()
            secondAnswerButton.backgroundColor = BaseColor.hex_E77D7D.uiColor().withAlphaComponent(0.25)
            secondAnswerButton.layer.borderColor = BaseColor.hex_E77D7D.cgColor()
            secondAnswerButton.layer.borderWidth = 2
        }
    }
    
    @objc func thirdClicked () {
        disableButton()
        if thirdAnswerButton.titleLabel?.text == correctAnswer {
            thirdAnswerButton.flash()
            thirdAnswerButton.backgroundColor = BaseColor.hex_81E89E.uiColor().withAlphaComponent(0.25)
            thirdAnswerButton.layer.borderColor = BaseColor.hex_81E89E.cgColor()
            thirdAnswerButton.layer.borderWidth = 2
        } else {
            thirdAnswerButton.shake()
            thirdAnswerButton.backgroundColor = BaseColor.hex_E77D7D.uiColor().withAlphaComponent(0.25)
            thirdAnswerButton.layer.borderColor = BaseColor.hex_E77D7D.cgColor()
            thirdAnswerButton.layer.borderWidth = 2
        }
    }
    
    @objc func fourthClicked () {
        disableButton()
        if fourthAnswerButton.titleLabel?.text == correctAnswer {
            fourthAnswerButton.flash()
            fourthAnswerButton.backgroundColor = BaseColor.hex_81E89E.uiColor().withAlphaComponent(0.25)
            fourthAnswerButton.layer.borderColor = BaseColor.hex_81E89E.cgColor()
            fourthAnswerButton.layer.borderWidth = 2
        } else {
            fourthAnswerButton.shake()
            fourthAnswerButton.backgroundColor = BaseColor.hex_E77D7D.uiColor().withAlphaComponent(0.25)
            fourthAnswerButton.layer.borderColor = BaseColor.hex_E77D7D.cgColor()
            fourthAnswerButton.layer.borderWidth = 2
        }
    }
    
    private func setDefaultButton() {
        firstAnswerButton.layer.borderWidth = 1
        firstAnswerButton.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        firstAnswerButton.backgroundColor = .white
        
        secondAnswerButton.layer.borderWidth = 1
        secondAnswerButton.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        secondAnswerButton.backgroundColor = .white
        
        thirdAnswerButton.layer.borderWidth = 1
        thirdAnswerButton.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        thirdAnswerButton.backgroundColor = .white
        
        fourthAnswerButton.layer.borderWidth = 1
        fourthAnswerButton.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
        fourthAnswerButton.backgroundColor = .white
        
        firstAnswerButton.isUserInteractionEnabled = true
        secondAnswerButton.isUserInteractionEnabled = true
        thirdAnswerButton.isUserInteractionEnabled = true
        fourthAnswerButton.isUserInteractionEnabled = true
    }
    
    private func disableButton() {
        firstAnswerButton.isUserInteractionEnabled = false
        secondAnswerButton.isUserInteractionEnabled = false
        thirdAnswerButton.isUserInteractionEnabled = false
        fourthAnswerButton.isUserInteractionEnabled = false
    }
}
