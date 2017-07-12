//
//  NewRestaurantViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantViewController: UIViewController {
    
    var restaurant: Restaurant!
    @IBOutlet weak var photoView: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var isSelected: Bool = false
    
    var imagePicker: UIImagePickerController?
    var img : UIImage! = UIImage(named: "camera")
    
    var isVisited : Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        imagePicker?.delegate = self
        
        nameTextField.delegate = self
        locationTextField.delegate = self
        typeTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        
    }
    func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print("收回键盘")
            nameTextField.resignFirstResponder()
            locationTextField.resignFirstResponder()
            typeTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension NewRestaurantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate{
    
    func setupUI(){
        
        yesBtn.setBackgroundImage(UIImage(named:"btn1"), for: .selected)
        yesBtn.setBackgroundImage(UIImage(named:"btn2"), for: .normal)
        yesBtn.isSelected = true
        yesBtn.addTarget(self, action: #selector(yesBtnClick), for: .touchUpInside)
        
        noBtn.setBackgroundImage(UIImage(named:"btn1"), for: .selected)
        noBtn.setBackgroundImage(UIImage(named:"btn2"), for: .normal)
        noBtn.isSelected = false
        noBtn.addTarget(self, action: #selector(noBtnClick), for: .touchUpInside)
        
        saveBtn.addTarget(self, action: #selector(saveRestaurant), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        
        photoView.addTarget(self, action: #selector(selectFromLocal), for: .touchUpInside)
        photoView.setImage(img, for: .normal)
    }
    
    func yesBtnClick(){
        isVisited = true
        yesBtn.isSelected = true
        noBtn.isSelected = false
    }
    
    func noBtnClick(){
        isVisited = false
        yesBtn.isSelected = false
        noBtn.isSelected = true
    }
    
    func selectFromLocal(){
        
        let imgVC = ImageViewController()
        self.present(imgVC, animated: true, completion: nil)
        
    }
    
    func cancelBtnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveRestaurant(){
        
        //插入数据的具体操作如下
        /*
         * 通过AppDelegate单例来获取管理的数据上下文对象，操作实际内容
         * 通过NSEntityDescription.insertNewObjectForEntityForName方法创建实体对象
         * 给实体对象赋值
         * 通过context.save()保存实体对象
         */
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: context) as! Restaurant
        
        restaurant.name = nameTextField.text
        restaurant.type = typeTextField.text
        restaurant.location = locationTextField.text
        restaurant.image = UIImagePNGRepresentation(photoView.image(for: .normal)!)! as NSData
        restaurant.isVisited = isVisited! as NSNumber
        
        do
        {
            try context.save()
            let alert = UIAlertController(title: "添加成功", message: "", preferredStyle: .alert)
            let commitAction = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                UIApplication.shared.keyWindow?.rootViewController = MainViewController()
            })
            alert.addAction(commitAction)
            self.present(alert, animated: true, completion: nil)
            print("添加成功 ~ ~ ")
            
        }catch
        {
            print("添加失败！！")
        }
    }
}


extension NewRestaurantViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
