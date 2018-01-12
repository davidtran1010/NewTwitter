//
//  HomeViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 12/30/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import UIKit
import TwitterKit
import Kingfisher
import SDWebImage
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, HomeView{
   
    
   
    let spinnerLoadMore = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var loadCount = 1
    var presenter:HomePresenter!
    var configuarator: HomeConfigurator!
    var refesher: UIRefreshControl?
    
   
    
    @IBOutlet weak var tweetComposer: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var tweetTableView: UITableView!
   
    var tweetModelArray:[TweetTableViewCellModel]?
    var userSession:TWTRSession?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refesher = UIRefreshControl()
        refesher!.attributedTitle = NSAttributedString(string: "Refesh tweets")
        
        refesher!.addTarget(self, action: #selector(HomeViewController.reloadTimeline), for: UIControlEvents.valueChanged)
        tweetTableView.addSubview(refesher!)
        
        spinnerLoadMore.color = UIColor.darkGray
        spinnerLoadMore.hidesWhenStopped = true
        tweetTableView.tableFooterView = spinnerLoadMore
        
        userPhoto.sd_setImage(with: URL(string: "http://pbs.twimg.com/profile_images/855170244469542915/qdlnkTq-_normal.jpg")!, completed: nil)
        tweetTableView.isHidden = true
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.rowHeight = 189
        configuarator = HomeConfiguratorImpl()
        configuarator.configure(homeViewController: self)
        
        presenter.viewDidLoad(with: userSession!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func updateTableView(array: [TweetTableViewCellModel]) {
        tweetModelArray = array
        
        spinnerLoadMore.stopAnimating()
        tweetTableView.isHidden = false
        tweetTableView.reloadData()
        loadingIcon.isHidden = true
    }
    func updateUserAccountInfo() {
        
    }
    func loadMoreTimeline(){
        presenter.refeshTimeline(count: UInt(50 * loadCount))
    }
    @objc func reloadTimeline(){
        presenter.refeshTimeline(count: 50)
    }
    
    
}

//MARK: - TWEET Tableview datasource and delegate
extension HomeViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = tweetModelArray?.count{
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = tweetModelArray![indexPath.row]
        if tweet.TweetPhotoURLStringArray!.count > 0{
            
            return 400
            
        }
        return 190
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetTableViewCell", for: indexPath) as! TweetTableViewCell
        let model = tweetModelArray![indexPath.row]
    
    
        if model.TweetPhotoURLStringArray!.count > 0{
             cell.photoCollectionView.isHidden = false
            
        }else{
             cell.photoCollectionView.isHidden = true
        }

        cell.configureItem(model: model)
        
        print("table cell:\(indexPath.row)")
        // set datasource and delegate for Collectionview in Tableviewcell
        //cell.photoCollectionView.dataSource = self
        //cell.photoCollectionView.delegate = self
        
        cell.setCollectionViewDataSourceDelegate(rootView: view, tableViewCellIndexpath: indexPath, data: model.TweetPhotoURLStringArray!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row + 1 == indexPath.count{
//            spinnerLoadMore.startAnimating()
//            loadCount = loadCount + 1
//            loadMoreTimeline()
//        }
    }
}

// MARK: - TWEET PHOTO Collectionview datasouce and delegate
//extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var itemCount = 0
//
//        if let tableViewCell = collectionView.superview?.superview?.superview as? TweetTableViewCell{
//            let tableViewCellIndexPath = tweetTableView.indexPath(for: tableViewCell)
//            let tableViewCellIndex = (tableViewCellIndexPath?.row)
//            itemCount = (tweetModelArray![tableViewCellIndex!].TweetPhotoURLStringArray?.count)!
//        }
//        return itemCount
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
//           print("collection cell:\(indexPath.item)")
//
//
//         var tweetPhotoArrayURLString:[String] = [String]()
//        // Get tableviewcell parent of collectionview
//        if let tableViewCell = collectionView.superview?.superview?.superview as? TweetTableViewCell{
//            let tableViewCellIndexPath = tweetTableView.indexPath(for: tableViewCell)
//            let tableViewCellIndex = (tableViewCellIndexPath?.row)!
//            tweetPhotoArrayURLString = (tweetModelArray![tableViewCellIndex].TweetPhotoURLStringArray)!
//        }
//
//
//
//        // change cell size depend on photos count
//        if tweetPhotoArrayURLString.count > 0{
//            cell.configure(photoURL: tweetPhotoArrayURLString[indexPath.item])
//            let layout = UICollectionViewFlowLayout()
//            layout.minimumLineSpacing = 0
//            layout.minimumInteritemSpacing = 0
//            if tweetPhotoArrayURLString.count == 1 {
//                    cell.bounds.size.width = view.safeAreaLayoutGuide.layoutFrame.size.width - 20
//            }
//            else{
//                     cell.bounds.size.width = view.safeAreaLayoutGuide.layoutFrame.size.width * 2/3
//            }
//        }
//
//
//        return cell
//    }
//
//}

