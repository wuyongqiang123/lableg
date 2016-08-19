//
//  ImageVC.swift
//  LabelG
//
//  Created by 永强 on 16/7/13.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ImageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var tableView: UITableView! = {
        let table = UITableView.init(frame: CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height), style: .Plain)
        table.delegate = self;
        table.dataSource = self
        table.tableHeaderView = self.headerBackView
        return table;
    }()
    var headerImageView: UIImageView!

    var headerBackView: UIView! {
        let headerBackView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        headerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        headerImageView.image = UIImage(named: "biz_news_local_weather_bg")
        headerImageView.contentMode = .ScaleAspectFill
        headerImageView.clipsToBounds = true
        headerBackView.addSubview(headerImageView)
        return headerBackView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()

        self.view.addSubview(self.tableView)
        
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

        let width = self.view.frame.size.width
        let offsetY = scrollView.contentOffset.y
        let totalOffset = 150 - offsetY
        let f = totalOffset / 150
        switch offsetY {
        case -300...5: //根据需要自己调整
            headerImageView.frame = CGRect(x: -(width * f - width) / 2, y: offsetY, width: width * f, height: totalOffset)
        default:
            break
        }
    }
}
