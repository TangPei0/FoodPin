//
//  WebViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/12.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension WebViewController{
    
    func setupUI(){
        let hdView = UIView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height*0.096))
        hdView.backgroundColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 1)
        view.addSubview(hdView)
        
        let returnBtn = UIButton(frame: CGRect(x:kBounds.width*0.064, y: kBounds.height*0.04, width: kBounds.width*0.075, height:kBounds.width*0.075))
        returnBtn.setTitle("<", for: .normal)
        returnBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        returnBtn.addTarget(self, action: #selector(returnBtnClick), for: .touchUpInside)
        view.addSubview(returnBtn)
        
        let hdLabel = UILabel(frame: CGRect(x: kBounds.width*0.2333, y: kBounds.height*0.03223, width: 200, height: 21))
        hdLabel.text = "About me"
        hdLabel.textColor = UIColor.white
        hdLabel.font = UIFont.systemFont(ofSize: 17)
        hdLabel.textAlignment = .center
        view.addSubview(hdLabel)
        
        webView = UIWebView(frame: CGRect(x: 0, y: kBounds.height*0.096, width: kBounds.width, height: kBounds.height*0.904))
        view.addSubview(webView)
        
        //打开网址方法一: loadRequest
//        if let url = URL(string: "http://www.baidu.com") {
//            let request = URLRequest(url: url)
//            webView.loadRequest(request)
//        }
        
        //方法二: iOS10弃用openURL
        //guard let url = URL(string: "http://www.fitiger.com") else{ return }
//        if UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
        
        //方法三: open(URL,options,competion:((Bool)->())?)
        guard let url = URL(string: "http://www.fitiger.com") else{ return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func returnBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
}
