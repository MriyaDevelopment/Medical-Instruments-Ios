//
//  NavigationBar.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

final class NavigationBar: UIView {

    private var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private var leftSideItemView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    private var rightSideItemView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    private var titleItemView: UIView = {
        let view = UIView()
        return view
    }()

    private var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_E5E5E5.uiColor()
        view.isHidden = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showBottomLine() {
        bottomLineView.isHidden = false
    }

    func addItem(_ view: UIView, toPosition: NavigationBarItemPosition) {

        switch toPosition {

        case .leftSide:
            leftSideItemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.lessThanOrEqualToSuperview()
                make.bottom.greaterThanOrEqualToSuperview()
                make.right.equalToSuperview()//lessThanOrEqualToSuperview()
                make.centerY.equalToSuperview()
            }
            leftSideItemView.isHidden = false

        case .title:
            titleItemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.right.equalToSuperview()
                make.top.lessThanOrEqualToSuperview()
                make.bottom.greaterThanOrEqualToSuperview()
                make.left.equalToSuperview()
                make.center.equalToSuperview()
            }

        case .rightSide:
            rightSideItemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.right.equalToSuperview()
                make.top.lessThanOrEqualToSuperview()
                make.bottom.greaterThanOrEqualToSuperview()
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            rightSideItemView.isHidden = false
        }
    }

    func hideItem(inPosition: NavigationBarItemPosition) {
        switch inPosition {
        case .leftSide:
            leftSideItemView.isHidden = true
        case .title:
            titleItemView.isHidden = true
        case .rightSide:
            rightSideItemView.isHidden = true
        }
    }

    func unhideItem(inPosition: NavigationBarItemPosition) {
        switch inPosition {
        case .leftSide:
            leftSideItemView.isHidden = false
        case .title:
            titleItemView.isHidden = false
        case .rightSide:
            rightSideItemView.isHidden = false
        }
    }
    
    func configureBySearchField() {
        leftSideItemView.isHidden = true
        rightSideItemView.isHidden = true
        
        titleItemView.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func addElements() {
        addSubview(backView)
        backView.addSubview(leftSideItemView)
        backView.addSubview(titleItemView)
        backView.addSubview(rightSideItemView)
        backView.addSubview(bottomLineView)

        makeConstraints()
    }

    private func makeConstraints() {

        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }

        leftSideItemView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        titleItemView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(leftSideItemView.snp.right).offset(10)
            make.right.equalTo(rightSideItemView.snp.left).offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        rightSideItemView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }

        bottomLineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

enum NavigationBarItemPosition {
    case leftSide
    case rightSide
    case title
}
