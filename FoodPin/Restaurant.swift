//
//  Restaurant.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import Foundation
import CoreData

@objc(Restaurant)
class Restaurant:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var isVisited:NSNumber!
}
