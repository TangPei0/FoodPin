//
//  MoreViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/12.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit
import MessageUI

class MoreViewController: UIViewController , UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func webBtnClick(_ sender: UIButton) {
        
        let webVC = WebViewController()
        self.present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func contactBtnClick(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MailViewController()
            self.present(mailVC, animated: true, completion: nil)
        }else{
            print("Can't send message!")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
