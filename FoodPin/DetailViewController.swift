//
//  DetailViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var restaurantImageView:UIImageView!
    var restaurantImage:String!
    var tableView: UITableView!
    
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor(colorLiteralRed: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        //self.restaurantImageView.image = UIImage(named: "restaurantImage")
    }
    
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
            cell.valueLabel.numberOfLines = 0
            cell.valueLabel.lineBreakMode = .byWordWrapping
            cell.mapBtn.isHidden = false
            cell.mapBtn.addTarget(self, action: #selector(showMapView), for: .touchUpInside)
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited.boolValue) ? "Yes" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }
    
    func showMapView(){
        let mapVC = MapViewController()
        mapVC.restaurant = restaurant
        self.present(mapVC, animated: true, completion: nil)
    }
}

extension DetailViewController{
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height*0.096))
        headView.backgroundColor = UIColor(colorLiteralRed: 231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.85)
        view.addSubview(headView)
        
        let hdLabel = UILabel(frame: CGRect(x: kBounds.width*0.3, y: kBounds.height*0.025, width: kBounds.width*0.4, height: kBounds.height*0.075))
        hdLabel.text = restaurant.name
        hdLabel.textColor = UIColor.white
        hdLabel.textAlignment = .center
        view.addSubview(hdLabel)
        
        let returnBtn = UIButton(frame: CGRect(x: 12, y: kBounds.height*0.04, width: kBounds.width*0.075, height:kBounds.width*0.075))
        returnBtn.setTitle("<", for: .normal)
        returnBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(returnBtn)
        returnBtn.addTarget(self, action: #selector(returnBtnClick), for: .touchUpInside)
        
        
        
        restaurantImageView = UIImageView(frame: CGRect(x: 0, y: kBounds.height*0.2, width: kBounds.width, height: kBounds.height*0.3))
        self.restaurantImageView.image = UIImage(data: restaurant.image as Data)
        restaurantImageView.contentMode = .scaleAspectFit
        view.addSubview(restaurantImageView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: kBounds.height*0.5, width: kBounds.width, height: kBounds.height*0.4))
        view.addSubview(tableView)
        
        let btmView = UIView(frame: CGRect(x: 0, y: kBounds.height*0.9, width: kBounds.width, height: kBounds.height*0.1))
        btmView.backgroundColor = UIColor(colorLiteralRed: 234/255, green: 236/255, blue: 238/255, alpha: 1)
        view.addSubview(btmView)
        
        let shareBtn = UIButton(frame: CGRect(x: kBounds.width*0.283, y: kBounds.height*0.934, width: kBounds.width*0.075, height: kBounds.width*0.075))
        shareBtn.setImage(UIImage(named: "share"), for: .normal)
        shareBtn.layer.cornerRadius = shareBtn.frame.size.width*0.5
        shareBtn.layer.masksToBounds = true
        shareBtn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        view.addSubview(shareBtn)
        
        let commentBtn = UIButton(frame: CGRect(x: kBounds.width*0.641, y: kBounds.height*0.929, width: kBounds.width*0.075, height: kBounds.width*0.085))
        commentBtn.layer.cornerRadius = commentBtn.frame.size.width*0.5
        commentBtn.layer.masksToBounds = true
        commentBtn.setImage(UIImage(named: "edit.jpg"), for: .normal)
        commentBtn.addTarget(self, action: #selector(commentBtnClick), for: .touchUpInside)
        view.addSubview(commentBtn)
        
    }
    
    func returnBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func shareBtnClick(){
        let svc = ShareViewController()
        self.present(svc, animated: true, completion: nil)
    }
    
    func commentBtnClick(){
        let cvc = CommentViewController()
        self.present(cvc, animated: true, completion: nil)
    }
    
    
}
