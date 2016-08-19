//
//  ASHorizontalVC.swift
//  LabelG
//
//  Created by 永强 on 16/7/4.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ASHorizontalVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let kCellHeight:CGFloat = 60.0
    var sampleTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.sampleTableView = UITableView(frame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height), style:.Grouped)
        sampleTableView.dataSource = self
        sampleTableView.delegate = self
        sampleTableView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.view.addSubview(sampleTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.sampleTableView.reloadData()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let CellIdentifierPortrait = "CellPortrait";
        let CellIdentifierLandscape = "CellLandscape";
        let indentifier = self.view.frame.width > self.view.frame.height ? CellIdentifierLandscape : CellIdentifierPortrait
        var cell = tableView.dequeueReusableCellWithIdentifier(indentifier)

        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: indentifier)
            cell?.selectionStyle = .None
            let horizontalScrollView:ASHorizontalScrollView = ASHorizontalScrollView(frame:CGRectMake(0, 0, tableView.frame.size.width, kCellHeight))
            if indexPath.row == 0{
                horizontalScrollView.miniAppearPxOfLastItem = 10
                horizontalScrollView.uniformItemSize = CGSizeMake(50, 50)
                //this must be called after changing any size or margin property of this class to get acurrate margin
                horizontalScrollView.setItemsMarginOnce()
                for _ in 1...20{
                    let button = UIButton(frame: CGRectZero)
                    button.backgroundColor = UIColor.blueColor()
                    horizontalScrollView.addItem(button)
                }
                
            }
            else if indexPath.row == 1 {
                horizontalScrollView.miniAppearPxOfLastItem = 30
                horizontalScrollView.uniformItemSize = CGSizeMake(80, 50)
                //this must be called after changing any size or margin property of this class to get acurrate margin
                horizontalScrollView.setItemsMarginOnce()
                for _ in 1...20{
                    let button = UIButton(frame: CGRectZero)
                    button.backgroundColor = UIColor.purpleColor()
                    horizontalScrollView.addItem(button)
                }
            }
            cell?.contentView.addSubview(horizontalScrollView)
            horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: kCellHeight))
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: cell!.contentView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        }
        return cell!
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return kCellHeight
    }
    
}
