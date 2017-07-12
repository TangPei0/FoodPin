//
//  CommentViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CommentViewController{
    
    func setupUI(){
        let bgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height))
        bgView.image = UIImage(named: "bg.jpg")
        view.addSubview(bgView)
        
        let cancelBtn = UIButton(frame: CGRect(x: kBounds.width*0.88, y: kBounds.height*0.045, width: kBounds.width*0.075, height: kBounds.width*0.075))
        cancelBtn.setImage(UIImage(named: "关闭"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        view.addSubview(cancelBtn)
        
        let label = UILabel(frame: CGRect(x: kBounds.width*0.21, y: kBounds.height*0.3, width: kBounds.width*0.58, height: kBounds.height*0.3))
        label.text = "     You've dined here.           What did you think?"
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        view.addSubview(label)
        
        let satisfiedBtn = UIButton(frame: CGRect(x: kBounds.width*0.21, y: kBounds.height*0.65, width: kBounds.width*0.16, height: kBounds.width*0.16))
        satisfiedBtn.setImage(UIImage(named: "满意.jpg"), for: .normal)
        satisfiedBtn.addTarget(self, action: #selector(satisfiedBtnClick), for: .touchUpInside)
        view.addSubview(satisfiedBtn)
        
        let goodBtn = UIButton(frame: CGRect(x: kBounds.width*0.4, y: kBounds.height*0.65,  width: kBounds.width*0.16, height: kBounds.width*0.16))
        goodBtn.setImage(UIImage(named: "一般.jpg"), for: .normal)
        goodBtn.addTarget(self, action: #selector(goodBtnClick), for: .touchUpInside)
        view.addSubview(goodBtn)
        
        let unsatisfiedBtn = UIButton(frame: CGRect(x: kBounds.width*0.6, y: kBounds.height*0.65,  width: kBounds.width*0.16, height: kBounds.width*0.16))
        unsatisfiedBtn.setImage(UIImage(named: "不满意.jpg"), for: .normal)
        unsatisfiedBtn.addTarget(self, action: #selector(unsatisfiedBtnClick), for: .touchUpInside)
        view.addSubview(unsatisfiedBtn)
        
    }
    
    func cancelBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func satisfiedBtnClick(){}
    func goodBtnClick(){}
    func unsatisfiedBtnClick(){}
}

