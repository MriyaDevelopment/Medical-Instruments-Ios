//
//  QuizVeiw.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 13.03.2022.
//

import UIKit
import Combine

final class QuizView: UIView {
    
    var events = PassthroughSubject<QuizViewEvents, Never>()
    
    var correctCount = 0
    private var questions: [Questions] = []
    private var currentQuestion = 0
    private var correctAnswer = ""
    private var firstQuestion = true
    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
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
        label.text = "00:00"
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
        stackView.axis = .vertical
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
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setTitleColor(BaseColor.hex_ECEDF0.uiColor(), for: .normal)
        button.setImage(AppIcons.getIcon(.i_arrow_right).withTintColor(BaseColor.hex_ECEDF0.uiColor()), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.isUserInteractionEnabled = false
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
    
    func configure(questions: [Questions]) {
        self.questions = questions
        configureQuestion(question: questions[currentQuestion])
        addTarget()
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
    
    func reloadData() {
        correctCount = 0
        currentQuestion = 0
        correctAnswer = ""
        firstQuestion = true
    }
    
    func setTimer(min: Int, sec: Int) {
        var minuts = ""
        var seconds = ""
        
        if min < 10 {
            minuts = "0" + "\(min)"
        } else {
            minuts = String(min)
        }
        
        if sec < 10 {
            seconds = "0" + "\(sec)"
        } else {
            seconds = String(sec)
        }
        
        timerLabel.text = "\(minuts):\(seconds)"
    }
    
    private func addElements() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
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
        firstStackView.addArrangedSubview(thirdAnswerButton)
        firstStackView.addArrangedSubview(fourthAnswerButton)
        
        contentView.addSubview(nextButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        scrollView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
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
            make.top.equalTo(countChalengesLabel.snp.bottom).offset(8)
            make.height.equalTo(8)
            make.right.left.equalToSuperview().inset(16)
        }
        
        imageContainer.snp.makeConstraints{ (make) in
            make.top.equalTo(progressBar.snp.bottom).offset(15)
            make.height.equalTo(300)
            make.right.left.equalToSuperview().inset(16)
        }
        
        instrumentImageView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview().inset(9)
        }
        
        firstStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(instrumentImageView.snp.bottom).offset(25)
            make.right.left.equalToSuperview().inset(16)
        }
        
        firstAnswerButton.snp.makeConstraints{ (make) in
            make.height.equalTo(45)
        }
        
        secondAnswerButton.snp.makeConstraints{ (make) in
            make.height.equalTo(45)
        }
        
        thirdAnswerButton.snp.makeConstraints{ (make) in
            make.height.equalTo(45)
        }
        
        fourthAnswerButton.snp.makeConstraints{ (make) in
            make.height.equalTo(45)
        }
        
        nextButton.snp.makeConstraints{ (make) in
            make.top.equalTo(firstStackView.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func addTarget() {
        firstAnswerButton.addTarget(self, action: #selector(firstClicked), for: .touchUpInside)
        secondAnswerButton.addTarget(self, action: #selector(secondClicked), for: .touchUpInside)
        thirdAnswerButton.addTarget(self, action: #selector(thirdClicked), for: .touchUpInside)
        fourthAnswerButton.addTarget(self, action: #selector(fourthClicked), for: .touchUpInside)
        
        if questions.count > 1 {
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        } else {
            nextButton.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
            nextButton.setTitle("Завершить тестирование", for: .normal)
        }
    }
    
    @objc func finishAction() {
        events.send(.finishQuiz)
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
        } else {
            events.send(.finishQuiz)
        }
    }
    
    @objc func firstClicked () {
        disableButton()
        buttonClicked(button: firstAnswerButton)
    }
    
    @objc func secondClicked () {
        disableButton()
        buttonClicked(button: secondAnswerButton)
    }
    
    @objc func thirdClicked () {
        disableButton()
        buttonClicked(button: thirdAnswerButton)
    }
    
    @objc func fourthClicked () {
        disableButton()
        buttonClicked(button: fourthAnswerButton)
    }
    
    private func buttonClicked(button: UIButton) {
        disableButton()
        if button.titleLabel?.text == correctAnswer {
            button.flash()
            button.layer.borderColor = BaseColor.hex_81E89E.cgColor()
            button.layer.borderWidth = 2
            correctCount += 1
        } else {
            button.shake()
            button.layer.borderColor = BaseColor.hex_E77D7D.cgColor()
            button.layer.borderWidth = 2
        }
        nextButton.isUserInteractionEnabled = true
        nextButton.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        nextButton.setImage(AppIcons.getIcon(.i_arrow_right), for: .normal)
    }
    
    private func setDefaultButton() {
        
        let buttons = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = BaseColor.hex_5B67CA.cgColor()
            button.backgroundColor = .white
            button.isUserInteractionEnabled = true
        }
        nextButton.isUserInteractionEnabled = false
        nextButton.setTitleColor(BaseColor.hex_ECEDF0.uiColor(), for: .normal)
        nextButton.setImage(AppIcons.getIcon(.i_arrow_right).withTintColor(BaseColor.hex_ECEDF0.uiColor()), for: .normal)
    }
    
    private func disableButton() {
        firstAnswerButton.isUserInteractionEnabled = false
        secondAnswerButton.isUserInteractionEnabled = false
        thirdAnswerButton.isUserInteractionEnabled = false
        fourthAnswerButton.isUserInteractionEnabled = false
    }
}
