//
//  ImportantNewsController.swift
//  LabelG
//
//  Created by 永强 on 16/7/13.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ImportantNewsController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var tableView: UITableView! = {
        let table = UITableView.init(frame: CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height), style: .Plain)
        table.delegate = self;
        table.dataSource = self
        table.contentInset = UIEdgeInsetsMake(self.tableViewInsetTop, 0, 0, 0)

        return table;
    }()
    lazy var imageView: UIImageView! = {
        let view = UIImageView.init(frame: CGRectMake(0, 0, self.topView.frame.size.width, 120))
        view.image = UIImage.init(named: "biz_news_local_weather_bg")
        return view
    }()
    var topView: UIView!
    lazy var titleLabel: UILabel! = {
        let title = UILabel.init(frame: CGRectMake(self.view.frame.size.width/2-45, 25, 90, 21))
        title.text = "24小时要闻"
        title.textColor = UIColor.whiteColor()
        title.textAlignment = .Center
        return title
    }()
    lazy var subtitleLabel: UILabel! = {
        let title = UILabel.init(frame: CGRectMake(self.view.frame.size.width/2-92, 65, 184, 15))
        title.text = "---- 聚焦今日时事 浓缩新闻精华 ----"
        title.textColor = UIColor.whiteColor()
        title.textAlignment = .Center
        title.font = UIFont.systemFontOfSize(11)
        return title
    }()

    lazy var tableViewInsetTop: CGFloat = {
        return self.imageView.frame.height
    }()

    lazy var maxOffsetY: CGFloat =  {
        return self.imageView.frame.height - self.topView.frame.height
    }()

    let maxScale: CGFloat = 1.5

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.topView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 55))
        self.topView.clipsToBounds = false
        self.topView.addSubview(self.imageView)
        self.topView.addSubview(self.titleLabel)
        self.topView.addSubview(self.subtitleLabel)

        self.view.addSubview(self.tableView)
        self.view.addSubview(self.topView)

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 35
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if  cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text  = "adsfkajsdlf"
        return cell!
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {

        print("\(scrollView.contentOffset)")
        let offsetY = scrollView.contentOffset.y
        var constant =  -(tableViewInsetTop + offsetY) < -maxOffsetY ? -maxOffsetY : -(tableViewInsetTop + offsetY)

        if constant >= 0 {
            constant = 0
            self.titleLabel.transform = CGAffineTransformMakeScale(maxScale, maxScale)
            self.subtitleLabel.alpha = 1

        }else if constant < 0 {
            let ratio = constant / -maxOffsetY

            let scale = maxScale - (maxScale - 1) * ratio
            self.subtitleLabel.alpha = 1 - ratio * 2

            self.titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
            
        }
        self.imageView.top = constant
    }

}

