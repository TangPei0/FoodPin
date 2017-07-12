//
//  CustomTabBarViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/12.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    class func customTabBar() -> UITabBarController{
        let mainVC = MainViewController()
        let feedVC = FeedViewController()
        let moreVC = MoreViewController()
        
        let nvc1 : UINavigationController = NVC.init(rootViewController: mainVC)
        let nvc2 : UINavigationController = NVC.init(rootViewController: feedVC)
        let nvc3 : UINavigationController = NVC.init(rootViewController: moreVC)
        
        let tabbar1 = UITabBarItem(title: "Favourite", image: UIImage(named:""), selectedImage: UIImage(named: ""))
        let tabbar2 = UITabBarItem(title: "Feed",  image: UIImage(named:""), selectedImage: UIImage(named: ""))
        let tabbar3 = UITabBarItem(title: "More",  image: UIImage(named:""), selectedImage: UIImage(named: ""))
        
        nvc1.tabBarItem = tabbar1;
        nvc2.tabBarItem = tabbar2;
        nvc3.tabBarItem = tabbar3;
        
        let tbc = UITabBarController()
        tbc.tabBar.tintColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 1)
        tbc.viewControllers = [nvc1,nvc2,nvc3];
        return tbc

    }
    
}

class NVC: UINavigationController {
    override func viewDidLoad() {
        
    }
}
