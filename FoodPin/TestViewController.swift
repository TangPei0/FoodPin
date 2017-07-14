//
//  TestViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/14.
//  Copyright © 2017年 唐培. All rights reserved.

import UIKit

class TestViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hdView = UIView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height*0.096))
        hdView.backgroundColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 1)
        view.addSubview(hdView)
        
        let hdLabel = UILabel(frame: CGRect(x: kBounds.width*0.2333, y: kBounds.height*0.03223, width: 200, height: 21))
        hdLabel.text = "FoodPin"
        hdLabel.textColor = UIColor.white
        hdLabel.font = UIFont.systemFont(ofSize: 17)
        hdLabel.textAlignment = .center
        view.addSubview(hdLabel)
        
        let rBtn = UIButton(frame: CGRect(x:kBounds.width*0.064, y: kBounds.height*0.04, width: kBounds.width*0.075, height:kBounds.width*0.075))
        rBtn.setTitle("<", for: .normal)
        rBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        rBtn.addTarget(self, action: #selector(rBtnClick), for: .touchUpInside)
        view.addSubview(rBtn)

        
        let tableView = UITableView(frame: CGRect(x: 0, y: kBounds.height*0.096, width: kBounds.width, height: kBounds.height*0.904))
        view.addSubview(tableView)
        
        loadData()
    }

    func rBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        let url = URL(string: "https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00NmfdwBQQC4yCf1a10f85b4spZ_wB")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task : URLSessionTask = session.dataTask(with: request) { (data, response, error) in
            if data != nil {
                let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            }else{
                print("null")
            }
        }
        task.resume()
    }
}

