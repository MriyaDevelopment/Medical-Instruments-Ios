//
//  CircularProgressBar.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 09.03.2022.
//

import UIKit

class CircularProgressBar: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        label.text = "0"
        
    }
    
    public var lineWidth:CGFloat = 6 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public var labelSize: CGFloat = 12 {
        didSet {
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            configLabel()
        }
    }
    
    public func setProgress(to progressConstant: Double) {
        
        let progress = progressConstant
        
        foregroundLayer.strokeEnd = CGFloat(progress)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = progress
        animation.duration = 2
        foregroundLayer.add(animation, forKey: "foregroundAnimation")
            
        var currentTime:Double = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            if currentTime >= 2{
                timer.invalidate()
            } else {
                currentTime += 0.05
                let percent = currentTime/2 * 100
                self.setForegroundLayerColorForSafePercent()
                self.configLabel()
            }
        }
        self.label.text = "\(Int(progress * 100))%"
        timer.fire()
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_5B67CA.uiColor()
        label.font = MainFont.medium(size: 14)
        return label
    }()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
            else { return (self.frame.height - lineWidth)/2 }
        }
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = BaseColor.hex_5B67CA.cgColor().copy(alpha: 0.25)
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 2/100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
    }
    
    private func drawForegroundLayer(){
        
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = BaseColor.hex_5B67CA.cgColor()
        
        self.layer.addSublayer(foregroundLayer)
    }
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    private func setForegroundLayerColorForSafePercent(){
            self.foregroundLayer.strokeColor = BaseColor.hex_5B67CA.cgColor()
    }
    
    private func setupView() {
        makeBar()
        self.addSubview(label)
    }
    

    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }
    
}
