//
//  loginView.swift
//  LabelG
//
//  Created by 永强 on 16/6/30.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit


extension Array {
    var random: Element? {
        return self.count != 0 ?
            self[Int(arc4random_uniform(UInt32(self.count)))] :
        nil
    }

    func appendRandomDescription<S: CustomStringConvertible>(input: S) -> String {

        if let element = self.random {
            return "\(element) " + input.description
        } else {
            return "empty array"
        }
    }

}

class loginView: UIView {

    var button: UIButton?
    var buttonLayer: CAShapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        button = UIButton.init(type: .Custom)
        button?.frame = CGRectMake(0, 10, 100, 40)
        button?.setTitle("登录", forState: .Normal)
        button?.titleLabel?.font = UIFont.systemFontOfSize(13)
        button?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button?.backgroundColor = UIColor.redColor()
        button?.layer.cornerRadius = 20
        button?.addTarget(self, action:#selector(loginView.btnAction(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(button!)
    }

    func btnAction(sender:UIButton) {
        if sender.selected {
            print("safsd")
            stopAnimation()
        }
        else{
            print("sssss")
            startAnimation()
        }

        sender.selected = !sender.selected;
    }
    func creatLayer() {
        //layer
        buttonLayer = CAShapeLayer()
        buttonLayer.strokeColor = UIColor.redColor().CGColor
        buttonLayer.fillColor = UIColor.clearColor().CGColor
        buttonLayer.lineWidth = 3
        buttonLayer.lineCap = kCALineCapSquare
        buttonLayer.lineDashPattern = [3,5]
        buttonLayer.path = UIBezierPath(roundedRect: CGRectMake(-5, -5, 50, 50), cornerRadius: 25).CGPath
        self.button!.layer.addSublayer(buttonLayer)

        /// 起点动画
        let strokeStartAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -1
        strokeStartAnimation.toValue = 1.0
        /// 终点动画
        let strokeEndAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        /// 组合动画
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.duration = 1.5
        animationGroup.repeatCount = Float(CGFloat.max)
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false
        buttonLayer.addAnimation(animationGroup, forKey: nil)
    }
    func removeLayer() {
        buttonLayer.removeFromSuperlayer()
    }
    func startAnimation() {

        UIView.animateWithDuration(0.5, animations: { 
            self.button?.frame = CGRectMake(self.frame.size.width/2-20, 10, 40, 40)
            }) { (finsh) in
                 self.creatLayer()
        }


    }
    func stopAnimation() {
        removeLayer()
        UIView.animateWithDuration(0.5) { 
            self.button?.frame = CGRectMake(0, 10, 100, 40)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
