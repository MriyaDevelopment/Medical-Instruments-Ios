//
//  UILabel.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont?, textColor: UIColor, lineHeight: CGFloat = 0, strikethroughText: Bool = false) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.numberOfLines = numberOfLines
        if lineHeight != 0 {
            setLineHeight(lineHeight)
        }
        if strikethroughText {
            setStrikethroughText()
        }
    }

    func halfTextColorChange (fullText: String, changeText: String, color: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
    
    func halfTextFontChange (fullText: String, changeText: String, font: UIFont, color: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
    
    func setLineHeight(_ lineHeight: CGFloat, alignment: NSTextAlignment = .left) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight - self.font.pointSize
            style.alignment = alignment
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: style,
                                         range: NSRange(location: 0, length: text.count))
            self.attributedText = attributeString
        }
    }
    
    func addKerning(kern: Double) {
        let text = self.text ?? ""
        let range = NSRange(location: 0, length: text.count)
        let mutableString = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        mutableString.addAttribute(NSAttributedString.Key.kern, value: kern, range: range)
        attributedText = mutableString
    }
    
    func setStrikethroughText() {
        let text = self.text ?? ""
        let range = NSRange(location: 0, length: text.count)
        let mutableString = NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString())
        mutableString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: range)
        self.attributedText = mutableString
    }
    
    
    func configure(baseString: String, valueString: String, font: UIFont) {
        let baseString = baseString
        let attributedString = NSMutableAttributedString(string: baseString)
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.headIndent = CGFloat(Double(baseString.count) * 6.5)
        style.lineHeightMultiple = 1.09
        
        let inputString = valueString

        let colorText = NSAttributedString(
            string: inputString,
            attributes: [
                NSAttributedString.Key.foregroundColor: BaseColor.hex_232324.uiColor(),
                NSAttributedString.Key.paragraphStyle: style,
                NSAttributedString.Key.font: font
            ]
        )
        
        attributedString.addAttributes([
            NSAttributedString.Key.paragraphStyle: style,
        ], range: NSRange(location: 0, length: baseString.count))
        
        attributedString.append(colorText)
        
        self.attributedText = attributedString
    }
}


class TagView: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setInsets(topInset: CGFloat, bottomInset: CGFloat, leftInset: CGFloat, rightInset: CGFloat) {
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(topInset)
            make.left.equalToSuperview().offset(leftInset)
            make.right.equalToSuperview().offset(-rightInset)
            make.bottom.equalToSuperview().offset(-bottomInset)
        }
    }
}
