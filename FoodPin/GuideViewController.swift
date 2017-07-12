//
//  GuideViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    var startBtn: UIButton!
    
    var scrollView : UIScrollView!
    let numOfPage : Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GuideViewController: UIScrollViewDelegate{
    
    func setupUI(){
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        scrollView.contentSize = CGSize(width: kBounds.width*CGFloat(numOfPage), height: kBounds.height)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        for index in 0..<numOfPage{
            let imgView = UIImageView(image: UIImage(named: "guide\(index+1)"))
            imgView.frame = CGRect(x: kBounds.width*CGFloat(index), y: 0, width: kBounds.width, height: kBounds.height)
            scrollView.addSubview(imgView)
        }
        
        startBtn = UIButton(frame: CGRect(x: (kBounds.width - 120)/2, y: kBounds.height*0.27, width: 120, height: 30))
        startBtn.backgroundColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.85)
        startBtn.setTitle("Get Started", for: .normal)
        startBtn.titleLabel?.textColor = UIColor.white
        startBtn.titleLabel?.textAlignment = .center
        startBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        startBtn.layer.cornerRadius = 15
        startBtn.alpha = 0
        startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(startBtn)
    }
    
    func start(){
        UIApplication.shared.keyWindow?.rootViewController = CustomTabBarController.customTabBar()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset  = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        if pageControl.currentPage == numOfPage-1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startBtn.alpha = 1
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.startBtn.alpha = 0
            })
        }
    }
    
}
