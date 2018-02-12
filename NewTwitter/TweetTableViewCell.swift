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

    var homeViewController:HomeViewController!
    
    var isLiked:Bool!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var LikeCount: UILabel!
    @IBOutlet weak var RetweetCount: UILabel!
    @IBOutlet weak var ReplyCount: UILabel!
    @IBOutlet weak var TweetOwnerPhoto: UIImageView!
    @IBOutlet weak var TweetOwnerName: UILabel!
    @IBOutlet weak var TweetPosedTime: UILabel!
    @IBOutlet weak var TweetContent: UILabel!
    
    fileprivate func initView(){
        TweetOwnerPhoto.layer.cornerRadius = 10
        TweetOwnerPhoto.clipsToBounds = true
        
    }
    func configureItem(homeViewController:HomeViewController, model: TweetTableViewCellModel){
        self.homeViewController = homeViewController
        initView()
        isLiked = model.isLiked!
        setLikeCountColor()
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
    func setLikeCountColor(){
        if isLiked{
            LikeCount.textColor = UIColor(displayP3Red: 74/255.0, green: 160/255.0, blue: 237/255.0, alpha: 1)
            LikeCount.font = UIFont.systemFont(ofSize: 13, weight: .black)
        }else{
            LikeCount.textColor = UIColor.black
            LikeCount.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    @IBOutlet weak var replyTweet: UIButton!
    @IBOutlet weak var reTweet: UIButton!
    
    @IBAction func likeTweet(_ sender: UIButton) {
        print("like button at section \(sender.tag)")
       homeViewController.likeTweetButtonPressed(tweetIndex: sender.tag)
    }
    @IBAction func replyTweet(_ sender: UIButton) {
        homeViewController.replyTweetButtonPressed(tweetIndex: replyButton.tag)
    }
    @IBAction func reTweet(_ sender: UIButton) {
    }
    
    
}


extension TweetTableViewCell{
    
}
extension TweetTableViewCell{
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDelegate & UICollectionViewDataSource>(_ dataSourceDelegate:D, forRow row:Int){
        print("set source and delegate cv table cell \(row)")
        photoCollectionView.delegate = dataSourceDelegate
        photoCollectionView.dataSource = dataSourceDelegate
        photoCollectionView.tag = row
        likeButton.tag = row
        replyButton.tag = row
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
