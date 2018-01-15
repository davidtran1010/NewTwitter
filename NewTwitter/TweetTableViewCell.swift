//
//  TweetTableViewCell.swift
//  NewTwitter
//
//  Created by DavidTran on 1/10/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var LikeCount: UILabel!
    @IBOutlet weak var RetweetCount: UILabel!
    @IBOutlet weak var ReplyCount: UILabel!
    @IBOutlet weak var TweetOwnerPhoto: UIImageView!
    
    @IBOutlet weak var TweetOwnerName: UILabel!
    
    @IBOutlet weak var TweetPosedTime: UILabel!
    
    @IBOutlet weak var TweetPhoto: UIImageView!
    
    @IBOutlet weak var TweetContent: UILabel!
    
    fileprivate func initView(){
        TweetOwnerPhoto.layer.cornerRadius = 10
        TweetOwnerPhoto.clipsToBounds = true
        
    }
    func configureItem(model: TweetTableViewCellModel){
        initView()
        LikeCount.text = "\(model.LikeCount!)"
        ReplyCount.text = ""
        RetweetCount.text = "\(model.RetweetCount!)"
        TweetOwnerName.text = model.TweetOwnerName
        TweetPosedTime.text = formatPostedTime(rawTime: model.TweetPosedTime!)
        TweetContent.text = model.TweetContent
        
        TweetOwnerPhoto.sd_setImage(with: URL(string: model.TweetOwnerPhotoURLString!)) { (image, error, cache, url) in
            if image != nil{
                print("owner tweet photo loaded with url:\(url?.absoluteString)")
                
            }
            else{
                print("load owner tweet photo error:\(error)")
                print(url?.absoluteString)
            }
        }
    }
    
    fileprivate func formatPostedTime(rawTime:String) -> String{
        let array = rawTime.split(separator: " ")
        
        let formatedTime = String(array[1]) + " " + String(array[2]) + ", " + String(array[5]) + " " + String(array[3])
        return formatedTime
     
    }
}
extension TweetTableViewCell{
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>(_ dataSourceDelegate:D, forRow row:Int){
        print("set source and delegate cv table cell \(row)")
        photoCollectionView.delegate = dataSourceDelegate
        photoCollectionView.dataSource = dataSourceDelegate
        photoCollectionView.tag = row
        photoCollectionView.reloadData()
        
        
    }
//    func setCollectionViewDataSourceDelegate
//        (rootView:UIView, tableViewCellIndexpath:IndexPath,data:[String]){
//
//        var collectionViewController = PhotoCollectionViewDataSource.init(rootView: rootView, tableViewCellIndexPath: tableViewCellIndexpath, photoURLStringArray: data)
//       // photoCollectionView.delegate = collectionViewController
//        photoCollectionView.dataSource = collectionViewController
//        photoCollectionView.reloadData()
//    }
}
