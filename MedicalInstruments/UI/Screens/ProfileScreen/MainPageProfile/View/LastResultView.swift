//
//  LastResultView.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import UIKit

final class LastresultView: UIView {
    
    var tryAgainClicked: VoidClosure?
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return view
    }()
    
    private var lastResultLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Ваш последний результат"
        return label
    }()
    
    private var difficultyLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 12)
        label.textColor = BaseColor.hex_232324.uiColor()
        label.text = "Легкий уровень"
        return label
    }()
    
    private var circularProgressBar = CircularProgressBar()
    
    private var verticalLiveView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_5B67CA.uiColor()
        return view
    }()
    
    private var categoriesChips = TagsCollectionView()
    
    private var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пройти тест заново", for: .normal)
        button.titleLabel?.font = MainFont.medium(size: 14)
        button.setTitleColor(BaseColor.hex_5B67CA.uiColor(), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.sizeToFit()
        button.setImage(AppIcons.getIcon(.i_arrow_right), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: GetResultData) {
        
        circularProgressBar.setProgress(to: Double(data.number_of_correct_answers ?? 1)/Double(data.number_of_questions ?? 2))
        
        switch data.level {
        case 1:
            difficultyLabel.text = "Уровень: Легкий"
        case 2:
            difficultyLabel.text = "Уровень: Средний"
        case 3:
            difficultyLabel.text = "Уровень: Сложный"
        default:
            break
        }
        
        let categories = data.categories?.components(separatedBy: ",") ?? []
       
        categoriesChips.configure(title: categories)
    }
    
    private func addElements() {
        addSubview(contentView)
        contentView.addSubview(circularProgressBar)
        contentView.addSubview(verticalLiveView)
        contentView.addSubview(lastResultLabel)
        contentView.addSubview(difficultyLabel)
        contentView.addSubview(categoriesChips)
        contentView.addSubview(tryAgainButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
        
        circularProgressBar.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(15)
            make.width.height.equalTo(66)
        }
        
        verticalLiveView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.left.equalTo(circularProgressBar.snp.right).offset(20)
            make.width.equalTo(2)
            make.height.equalTo(35)
        }
        
        lastResultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(verticalLiveView.snp.top)
            make.left.equalTo(verticalLiveView.snp.right).offset(5)
        }
        
        difficultyLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(verticalLiveView.snp.bottom)
            make.left.equalTo(verticalLiveView.snp.right).offset(5)
        }
        
        categoriesChips.snp.makeConstraints { (make) in
            make.top.equalTo(circularProgressBar.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        tryAgainButton.snp.makeConstraints { (make) in
            make.top.equalTo(categoriesChips.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-32)
        }
        
    }
    func addTarget() {
        tryAgainButton.addTarget(self, action: #selector(tryAgainAction), for: .touchUpInside)
    }
    
    @objc func tryAgainAction() {
        tryAgainClicked?()
    }
}
