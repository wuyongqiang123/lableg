//
//  ViewController.swift
//  LabelG
//
//  Created by 永强 on 16/6/30.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button: UIButton?
    var button1: UIButton?
    var starView:StarView = StarView(frame: CGRectMake(100, 50, 100, 100))
    var login: loginView = loginView.init(frame: CGRectMake(100, 200, 100, 60))
    let onOffButton = OnOffButton()

    var lab: UILabel!
    var startTime = NSTimeInterval()
    var timer:NSTimer = NSTimer()
    var endTime: NSDate!
    var alarmTime: NSDate!


    var caELayer: CAEmitterLayer!

   override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(starView)
        self.view.addSubview(login)
        button = UIButton.init(type: .Custom)
        button?.frame = CGRectMake(100, 300, 40, 50)
        button?.backgroundColor = UIColor.redColor()
        button?.addTarget(self, action: #selector(ViewController.ss), forControlEvents: .TouchUpInside)
        self.view.addSubview(button!)

        button1 = UIButton.init(type: .Custom)
        button1?.frame = CGRectMake(100, 380, 40, 50)
        button1?.backgroundColor = UIColor.blueColor()
        button1?.addTarget(self, action: #selector(ViewController.ssss), forControlEvents: .TouchUpInside)
        self.view.addSubview(button1!)

        onOffButton.frame = CGRect(origin: CGPointMake(0, 100), size:CGSize(width: 100,height: 100))
        // Adjust properties
//        onOffButton.backgroundColor = UIColor.redColor()
        onOffButton.lineWidth = 5
        onOffButton.strokeColor = UIColor.greenColor()
        onOffButton.ringAlpha = 0.3
        onOffButton.addTarget(self, action: #selector(ViewController.didTapOnOffButton), forControlEvents: .TouchUpInside)

        view.addSubview(onOffButton)

        lab = UILabel.init(frame: CGRectMake(0, 250, 100, 30))
        lab.textColor  = UIColor.blueColor()
        lab.text = "00:00:00"
        view.addSubview(lab)

        let okBtn = UIButton.init(type: .Custom)
        okBtn.frame = CGRectMake(0, 300, 40, 30)
        okBtn.backgroundColor = UIColor.redColor()
        okBtn.addTarget(self, action: #selector(ViewController.start), forControlEvents: .TouchUpInside)
        view.addSubview(okBtn)

        let calBtn = UIButton.init(type: .Custom)
        calBtn.frame = CGRectMake(okBtn.right+10, 300, 40, 30)
        calBtn.backgroundColor = UIColor.redColor()
        calBtn.addTarget(self, action: #selector(ViewController.stop), forControlEvents: .TouchUpInside)
        view.addSubview(calBtn)


        let buttons: LY_CircleButton = LY_CircleButton(type: .Custom)
        buttons.frame = CGRectMake(0, 0, 30, 30)
        buttons.center = self.view.center
        buttons.backgroundColor = UIColor.redColor()
        buttons.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttons.setTitle("100", forState: .Normal)
        self.view!.addSubview(buttons)

    }
    func showLoveHeartView() {

        let heart = XTLoveHeartView.init(frame: CGRectMake(0, 0, 40, 40))
        self.view.addSubview(heart)
        let fountainSource = CGPointMake(self.view.width - 80, self.view.height - 30 / 2.0 - 10);
        heart.center = fountainSource
        heart.animateInView(self.view)
    }

    func EmitterLayer() {

        self.caELayer = CAEmitterLayer()
        // 发射源
        self.caELayer.emitterPosition = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50)
        // 发射源尺寸大小
        self.caELayer.emitterSize = CGSizeMake(50, 0)
        // 发射源模式
        self.caELayer.emitterMode = kCAEmitterLayerOutline
        // 发射源的形状
        self.caELayer.emitterShape = kCAEmitterLayerLine
        // 渲染模式
        self.caELayer.renderMode = kCAEmitterLayerAdditive
        // 发射方向
        self.caELayer.velocity = 1
        // 随机产生粒子
        self.caELayer.seed = (arc4random() % 100) + 1

        // cell
        let cell: CAEmitterCell = CAEmitterCell()
        // 速率
        cell.birthRate = 1.0
        // 发射的角度
        cell.emissionRange = 0.11 * CGFloat(M_PI)
        // 速度
        cell.velocity = 300
        // 范围
        cell.velocityRange = 150
        // Y轴 加速度分量
        cell.yAcceleration = 75
        // 声明周期
        cell.lifetime = 2.04
        //是个CGImageRef的对象,既粒子要展现的图片
        cell.contents = (UIImage(named: "FFRing")!.CGImage as! AnyObject)
        // 缩放比例
        cell.scale = 0.2
        // 粒子的颜色
        cell.color = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0).CGColor

        // 一个粒子的颜色green 能改变的范围
        cell.greenRange = 1.0
        // 一个粒子的颜色red 能改变的范围
        cell.redRange = 1.0
        // 一个粒子的颜色blue 能改变的范围
        cell.blueRange = 1.0
        // 子旋转角度范围
        cell.spinRange = CGFloat(M_PI)
        // 爆炸
        let burst: CAEmitterCell = CAEmitterCell()
        // 粒子产生系数
        burst.birthRate = 1.0
        // 速度
        burst.velocity = 0
        // 缩放比例
        burst.scale = 2.5
        // shifting粒子red在生命周期内的改变速度
        burst.redSpeed = -1.5
        // shifting粒子blue在生命周期内的改变速度
        burst.blueSpeed = 1.5
        // shifting粒子green在生命周期内的改变速度
        burst.greenSpeed = 1.0
        //生命周期
        burst.lifetime = 0.35

        // 火花 and finally, the sparks
        let spark: CAEmitterCell = CAEmitterCell()
        //粒子产生系数，默认为1.0
        spark.birthRate = 400
        //速度
        spark.velocity = 125
        // 360 deg//周围发射角度
        spark.emissionRange = 2 * CGFloat(M_PI)
        // gravity//y方向上的加速度分量
        spark.yAcceleration = 75
        //粒子生命周期
        spark.lifetime = 3
        //是个CGImageRef的对象,既粒子要展现的图片
        spark.contents = (UIImage(named: "FFTspark")!.CGImage as! AnyObject)
        //缩放比例速度
        spark.scaleSpeed = -0.2
        //粒子green在生命周期内的改变速度
        spark.greenSpeed = -0.1
        //粒子red在生命周期内的改变速度
        spark.redSpeed = 0.4
        //粒子blue在生命周期内的改变速度
        spark.blueSpeed = -0.1
        //粒子透明度在生命周期内的改变速度
        spark.alphaSpeed = -0.25
        //子旋转角度
        spark.spin = 2 * CGFloat(M_PI)
        //子旋转角度范围
        spark.spinRange = 2 * CGFloat(M_PI)

        self.caELayer.emitterCells = [cell]
        cell.emitterCells = [burst]
        burst.emitterCells = [spark]
        self.view.layer.addSublayer(self.caELayer)

    }
    func start() {

        alarmTime = NSDate()
        if (!timer.valid) {
            let aSelector : Selector = #selector(ViewController.updateTime)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
        EmitterLayer()

    }
    func stop() {
        
        endTime = NSDate()
        timer.invalidate()

        showLoveHeartView()
    }

    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()

        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime

        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)

        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)

        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)

        //add the leading zero for minutes, seconds and millseconds and store them as string constants

        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)

        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        lab.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }

    func didTapOnOffButton() {
        onOffButton.checked = !onOffButton.checked
        //网易24小时要闻效果
        let impo = ImportantNewsController()
        //头部放大效果
//        let impo = ImageVC()
        self.presentViewController(impo, animated: true) {

        }
    }
    func ss() {
        let num:Int = Int(arc4random_uniform(99))
        starView.startLoadNumber(num)
    }

    func ssss() {
        let ss = ASHorizontalVC()
        self.presentViewController(ss, animated: true) { 

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

/*
CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
// 发射器在xy平面的中心位置
emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
// 发射器的尺寸大小
emitterLayer.emitterSize = CGSizeMake(20, 20);
// 渲染模式
emitterLayer.renderMode = kCAEmitterLayerUnordered;
// 开启三维效果
//    _emitterLayer.preservesDepth = YES;
NSMutableArray *array = [NSMutableArray array];
// 创建粒子
for (int i = 0; i<10; i++) {
    // 发射单元
    CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
    // 粒子的创建速率，默认为1/s
    stepCell.birthRate = 1;
    // 粒子存活时间
    stepCell.lifetime = arc4random_uniform(4) + 1;
    // 粒子的生存时间容差
    stepCell.lifetimeRange = 1.5;
    // 颜色
    // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
    // 粒子显示的内容
    stepCell.contents = (id)[image CGImage];
    // 粒子的名字
    //            [fire setName:@"step%d", i];
    // 粒子的运动速度
    stepCell.velocity = arc4random_uniform(100) + 100;
    // 粒子速度的容差
    stepCell.velocityRange = 80;
    // 粒子在xy平面的发射角度
    stepCell.emissionLongitude = M_PI+M_PI_2;;
    // 粒子发射角度的容差
    stepCell.emissionRange = M_PI_2/6;
    // 缩放比例
    stepCell.scale = 0.3;
    [array addObject:stepCell];
}

emitterLayer.emitterCells = array;
[self.moviePlayer.view.layer insertSublayer:emitterLayer below:self.catEarView.layer];
*/
