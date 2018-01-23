//
//  SideMenuTableViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 1/22/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {


    @IBOutlet weak var userFollowersCount: UILabel!
    @IBOutlet weak var userFollowingsCount: UILabel!
    @IBOutlet weak var userTweetsCount: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userBannerImage: UIImageView!
    var userInfo:UserInfoResponse!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        initUIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func initUIView(){
        userPhoto.layer.cornerRadius = 10
        userPhoto.clipsToBounds = true
        
        userFollowersCount.text = "\(userInfo.followersCount!)"
        userFollowingsCount.text = "\(userInfo.friendsCount!)"
        userTweetsCount.text = "\(userInfo.statusesCount!)"
        userName.text = "\(userInfo.screenName!)"
        userPhoto.sd_setImage(with: URL(string:userInfo.profileImageUrlHttps!)) { (image, error, cache, url) in
            if image != nil{
                print("side menu profile image is loaded with url:\(url)")
            }
            else{
                print("failed to load side menu profile image")
            }
        }
        userBannerImage.sd_setImage(with: URL(string:userInfo.profileBannerUrl!)) { (image, error, cache, url) in
            if image != nil{
                print("side menu banner image is loaded with url:\(url)")
            }
            else{
                print("failed to load side menu banner image")
            }
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("side menu row \(indexPath.row) selected")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
