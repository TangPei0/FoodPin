//
//  ImageViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var imagePicker : UIImagePickerController?
    var s_imgView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

extension ImageViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        
        let hd_view = UIView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height*0.096))
        hd_view.backgroundColor = UIColor(colorLiteralRed: 217/255, green: 87/255, blue: 89/255, alpha: 1)
        view.addSubview(hd_view)
        
        let cancel_btn = UIButton(frame: CGRect(x: kBounds.width*0.0427, y: kBounds.width*0.0427, width: kBounds.width*0.085, height: kBounds.width*0.085))
        cancel_btn.setImage(UIImage(named:"取消"), for: .normal)
        cancel_btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        hd_view.addSubview(cancel_btn)
        
        let hd_label = UILabel(frame: CGRect(x: kBounds.width*0.39, y: kBounds.height*0.0315, width: kBounds.width*0.176, height: kBounds.height*0.033))
        hd_label.text = "所有照片"
        hd_label.textColor =  UIColor.white
        hd_view.addSubview(hd_label)
        
        let hd_btn = UIButton(frame: CGRect(x: kBounds.width*0.565, y: kBounds.height*0.03, width: kBounds.width*0.064, height: kBounds.width*0.064))
        hd_btn.setImage(UIImage(named: "下切换"), for: .normal)
        hd_btn.addTarget(self, action: #selector(selectFromLocal), for: .touchUpInside)
        hd_view.addSubview(hd_btn)
        
        s_imgView = UIImageView(frame: CGRect(x: 0, y: kBounds.height*0.096, width: kBounds.width, height: kBounds.width))
        view.addSubview(s_imgView!)
        
        let cm_btn = UIButton(frame: CGRect(x: 0, y: kBounds.height*0.92, width: kBounds.width, height: kBounds.height*0.08))
        cm_btn.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        cm_btn.setTitle("确定", for: .normal)
        cm_btn.addTarget(self, action: #selector(commit), for: .touchUpInside)
        view.addSubview(cm_btn)
    }
    
    func cancel(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func selectFromLocal(){
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        imagePicker?.allowsEditing = true
        present(imagePicker!, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        s_imgView?.image = img
        imagePicker?.dismiss(animated: true, completion: nil)
        
        
    }
    
    func commit(){
        
        if self.s_imgView?.image != nil {
            let nvc = NewRestaurantViewController()
            nvc.img = self.s_imgView?.image
            self.present(nvc, animated: true, completion: nil)
            imagePicker?.dismiss(animated: true, completion: nil)
        }
        
        
    }
}
