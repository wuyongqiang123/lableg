//
//  StarView.swift
//  LabelG
//
//  Created by 永强 on 16/6/30.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class StarView: UIView {
    //进度
    var progressLayer: CAShapeLayer = CAShapeLayer()
    //文字
    var passesLabel:UILabel = UILabel(frame: CGRectMake(15, 64, 60, 20))
    //个位label
    var tensSliderContainer:SliderLabelContainer = SliderLabelContainer(frame: CGRectMake(27, 13, 20, 45), type: SliderLabelContainerType.TensDigitType)
    //十位label
    var singleSliderContainer:SliderLabelContainer = SliderLabelContainer(frame: CGRectMake(50, 13, 20, 45), type: SliderLabelContainerType.SingleDigitType)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        
        progressLayer.lineWidth = 2
        progressLayer.fillColor = UIColor.clearColor().CGColor
        progressLayer.strokeColor = UIColor.redColor().CGColor
        self.layer.addSublayer(progressLayer)
        
        passesLabel.font = UIFont.systemFontOfSize(15)
        passesLabel.text = "PASSES"
        passesLabel.textColor = UIColor.redColor()
        passesLabel.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2+20.0)
        passesLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(passesLabel)
        
        self.addSubview(singleSliderContainer)
        
        self.addSubview(tensSliderContainer)
        
    }
    //开始动画
    func startLoadNumber(num:Int){
        let tensDigit:Int = num/10
        let singleDigit:Int = num%10
        
        tensSliderContainer.scrollToNum(tensDigit)
        singleSliderContainer.scrollToNum(singleDigit)
        
        startDrawCircleAnimation()
    }
    
    override func layoutSubviews() {
        
        let radius:CGFloat = CGRectGetWidth(self.bounds)/2.0
        let center = CGPointMake(radius, radius)
        let startAngle = -M_PI_2
        let endAngle = M_PI_2*3.0
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        progressLayer.path = circlePath.CGPath
    }
    //画圆
    func startDrawCircleAnimation(){
        let pathAnimation:CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.duration = 0.5
        progressLayer.addAnimation(pathAnimation, forKey: "pathAnimation")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
