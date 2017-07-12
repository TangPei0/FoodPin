//
//  MainViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UIViewController {
    
    var hdView: UIView!
    var hdLabel: UILabel!
    
    var tableView: UITableView!
    
    var restaurants: [Restaurant]!
    var searchController : UISearchController!
    var searchResults : [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //查询数据的具体操作如下
        /*
         *获取application管理上下文单例
         * 利用NSFetchRequest方法来声明数据的请求，相当于查询语句
         * 利用NSEntityDescription.entityForName方法声明一个实体结构，相当于表格结构
         * 利用NSPredicate创建一个查询条件，并设置请求的查询条件
         * 通过context.fetch执行查询操作
         * 使用查询出来的数据
         */
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        
        let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Restaurant", in: context)
        fetchResult.entity = entity
        
        do {
            try restaurants = context.fetch(fetchResult) as! [Restaurant]
        } catch  {
            print("失败")
        }
        
        hdView = UIView(frame: CGRect(x: 0, y: 0, width: kBounds.width, height: kBounds.height*0.096))
        hdView.backgroundColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 1)
        view.addSubview(hdView)
        
        hdLabel = UILabel(frame: CGRect(x: kBounds.width*0.2333, y: kBounds.height*0.03223, width: 200, height: 21))
        hdLabel.text = "FoodPin"
        hdLabel.textColor = UIColor.white
        hdLabel.font = UIFont.systemFont(ofSize: 17)
        hdLabel.textAlignment = .center
        view.addSubview(hdLabel)
        
        let addBtn = UIButton(frame: CGRect(x:kBounds.width*0.9, y: kBounds.height*0.04, width: kBounds.width*0.075, height:kBounds.width*0.075))
        addBtn.setTitle("+", for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        view.addSubview(addBtn)
        
        tableView = UITableView(frame: CGRect(x: 0, y: kBounds.height*0.096, width: kBounds.width, height: kBounds.height*0.904))
        view.addSubview(tableView)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchBar.barTintColor = UIColor(colorLiteralRed:231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.85)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    func addBtnClick(){
        let newVC = NewRestaurantViewController()
        self.present(newVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
}

//searchcontroller
extension MainViewController: UISearchResultsUpdating{
    
    func filterContentForSearchText(searchText: String) {
        searchResults = restaurants.filter({ ( restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.range(of: searchText, options: NSString.CompareOptions.caseInsensitive, range:nil, locale: nil)
            return nameMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText: searchText!)
        tableView.reloadData()
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
    //section个数
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return self.restaurants.count
        }
        //return restaurants.count
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //每行数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let restaurant = restaurants[indexPath.row]
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImgView.image = UIImage(data: restaurant.image as Data)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.likeImgView.image = UIImage(named: "赞")
        cell.likeImgView.isHidden = !restaurant.isVisited.boolValue
        cell.accessoryType = restaurant.isVisited.boolValue ? .checkmark : .none
        
        return cell
    }
    
    //
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    //选中
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        //取消
        let cancelAction =  UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //打电话
        let callAction = UIAlertAction(title: "Call "+"123-000-\(indexPath.row)", style: .default) { (action) in
            let alertMessage = UIAlertController(title: "Service unavailable", message: "Sorry, the call feature isunavailable yet.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
            
        }
        
        let isVisitedAction = UIAlertAction(title: "I've been here", style: .default) { (action) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurants[indexPath.row].isVisited = true
        }
        
        let detailAction = UIAlertAction(title: "Show me the restaurant's detail", style: .default) { (action) in
            let detailVC = DetailViewController()
            //detailVC.restaurant = self.restaurants[indexPath.row]
            detailVC.restaurant = (self.searchController.isActive) ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row]
            self.present(detailVC, animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(callAction)
        alert.addAction(isVisitedAction)
        alert.addAction(detailAction)
        
        if searchController.isActive {
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            self.dismiss(animated: true, completion: nil)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    //删除事件提交
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath:IndexPath){
        //删除
        if editingStyle == .delete{
            let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Restaurant", in: context)
            fetchResult.entity = entity
            let restaurantToDelete = self.restaurants[indexPath.row]
            
            do{
                context.delete(restaurantToDelete)
                try context.save()
                print("删除成功")
                
                
            }catch{
                print("删除失败")
            }
            
            
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //编辑事件
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //分享项
        let shareAction = UITableViewRowAction(style: .default, title: "分享") { (action, indexPath) in
            //分享目标
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
            
            let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style: .default, handler: nil)
            let emailAction = UIAlertAction(title: "Emain", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            self.present(shareMenu, animated: true, completion: nil)
        }
        
        //删除
        let deleteAction = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            
            
            //删除数据的具体操作如下
            /*
             * 利用NSFetchRequest方法来声明数据的请求，相当于查询语句
             * 利用NSEntityDescription.entityForName方法声明一个实体结构，相当于表格结构
             * 利用NSPredicate创建一个查询条件，并设置请求的查询条件
             * 通过context.fetch执行查询操作
             * 通过context.delete删除查询出来的某一个对象
             * 通过saveContext()保存修改后的实体对象
             */
            let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Restaurant", in: context)
            fetchResult.entity = entity
            let restaurantToDelete = self.restaurants[indexPath.row]
            //
            do{
                context.delete(restaurantToDelete)
                try context.save()
                print("删除成功")
                
            }catch{
                print("删除失败")
            }
            
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
        
        shareAction.backgroundColor = UIColor.orange
        shareAction.backgroundColor = UIColor.blue
        
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue:
            51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue:
            51.0/255.0, alpha: 1.0)
        
        return [shareAction,deleteAction]
    }
    
    
    
}
