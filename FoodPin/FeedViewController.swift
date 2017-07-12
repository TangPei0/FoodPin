//
//  FeedViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/12.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let hdView = UIView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height*0.096))
        hdView.backgroundColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 1)
        view.addSubview(hdView)
        
        let hdLabel = UILabel(frame: CGRect(x: kBounds.width*0.2333, y: kBounds.height*0.03223, width: 200, height: 21))
        hdLabel.text = "Feed"
        hdLabel.textColor = UIColor.white
        hdLabel.font = UIFont.systemFont(ofSize: 17)
        hdLabel.textAlignment = .center
        view.addSubview(hdLabel)
        
        let tableView = UITableView(frame: CGRect(x: 0, y: kBounds.height*0.096, width: kBounds.width, height: kBounds.height*0.82))
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

}
