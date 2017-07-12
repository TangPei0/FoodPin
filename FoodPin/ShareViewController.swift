//
//  ShareViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    var fbBtn : UIButton!
    var wbBtn: UIButton!
    var wcBtn: UIButton!
    var qqBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.animation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ShareViewController{
    
    func setupUI(){
        let bgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height))
        bgView.image = UIImage(named: "bg.jpg")
        view.addSubview(bgView)
        
        let cancelBtn = UIButton(frame: CGRect(x: kBounds.width*0.88, y: kBounds.height*0.045, width: kBounds.width*0.075, height: kBounds.width*0.075))
        cancelBtn.setImage(UIImage(named: "关闭"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        view.addSubview(cancelBtn)
        
        fbBtn = UIButton(frame: CGRect(x: kBounds.width*0.28667, y: -kBounds.width*0.21333, width: kBounds.width*0.21333, height: kBounds.width*0.21333))
        fbBtn.setImage(UIImage(named:"facebook.jpg"), for: .normal)
        fbBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
        fbBtn.alpha = 0
        view.addSubview(fbBtn)
        
        wbBtn = UIButton(frame: CGRect(x: kBounds.width*0.5, y: -kBounds.width*0.21333, width: kBounds.width*0.21333, height: kBounds.width*0.21333))
        wbBtn.setImage(UIImage(named:"weibo.jpg"), for: .normal)
        wbBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
        wbBtn.alpha = 0
        view.addSubview(wbBtn)
        
        wcBtn = UIButton(frame: CGRect(x: kBounds.width*0.28667, y: kBounds.height, width: kBounds.width*0.21333, height: kBounds.width*0.21333))
        wcBtn.setImage(UIImage(named:"wechat.jpg"), for: .normal)
        wcBtn.alpha = 0
        wcBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
        view.addSubview(wcBtn)
        
        qqBtn = UIButton(frame: CGRect(x: kBounds.width*0.5, y: kBounds.height, width: kBounds.width*0.21333, height: kBounds.width*0.21333))
        qqBtn.setImage(UIImage(named:"qq.jpg"), for: .normal)
        qqBtn.alpha = 0
        qqBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
        view.addSubview(qqBtn)
    }
    
    func cancelBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func shareBtnClick(_ sender: UIButton){
        
    }
    
    func animation(){
        UIView.animate(withDuration: 0.5) {
            self.fbBtn.alpha = 1
            self.wcBtn.alpha = 1
            self.fbBtn.frame.origin.y += kBounds.height*0.5
            self.wcBtn.frame.origin.y -= kBounds.height*0.5
        }
        UIView.animate(withDuration: 1.5) {
            self.wbBtn.alpha = 1
            self.qqBtn.alpha = 1
            self.wbBtn.frame.origin.y += kBounds.height*0.5
            self.qqBtn.frame.origin.y -= kBounds.height*0.5
        }
    }
    
}
