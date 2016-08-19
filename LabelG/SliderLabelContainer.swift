//
//  SliderLabelContainer.swift
//  LabelG
//
//  Created by 永强 on 16/6/30.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

enum SliderLabelContainerType{
    case SingleDigitType
    case TensDigitType
}

class SliderLabelContainer: UIView {
    
    var singleDigitsScroll:UIScrollView!
    private var scrollType:SliderLabelContainerType = SliderLabelContainerType.SingleDigitType

    init(frame: CGRect, type:SliderLabelContainerType) {
        super.init(frame: frame)
        
        scrollType = type
        
        singleDigitsScroll = UIScrollView(frame: self.bounds)
        singleDigitsScroll.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)*10)
        for i in 0...10{
            let label:UILabel = UILabel(frame: CGRectMake(0, CGRectGetHeight(self.bounds) * CGFloat(i), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)))
            label.text = "\(i)"
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.boldSystemFontOfSize(30)
            label.textColor = UIColor.redColor()
            singleDigitsScroll.addSubview(label)
        }
        
        self.addSubview(singleDigitsScroll)
    }
    
    func scrollToNum(num:Int){

        if scrollType == .SingleDigitType{
            UIView.animateWithDuration(0.85, animations: { () -> Void in
                self.singleDigitsScroll.contentOffset = CGPointMake(0, CGRectGetHeight(self.bounds) * CGFloat(num))
            })
        }else
        {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.singleDigitsScroll.contentOffset = CGPointMake(0, CGRectGetHeight(self.bounds) * CGFloat(num))
            })
        }
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
