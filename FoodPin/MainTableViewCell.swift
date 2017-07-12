//
//  MainTableViewCell.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var likeImgView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImgView.layer.cornerRadius = thumbnailImgView.frame.size.width/2
        thumbnailImgView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
