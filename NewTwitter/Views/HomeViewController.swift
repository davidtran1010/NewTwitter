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
import ImageViewer

struct Constants{
    static let MAX_COUNT_OF_FIRST_TWEETS = 50
    static let THRESHOLD_TO_LOAD_MORE = 48
}
class HomeViewController: UIViewController, HomeView{
    var lastIndexTableViewCell = Constants.THRESHOLD_TO_LOAD_MORE
    var countOfFirstTweets = Constants.MAX_COUNT_OF_FIRST_TWEETS
    
    //var photoCollectionViewDataSource:PhotoCollectionViewDataSource?
    let spinnerLoadMore = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var loadCount = 1
    var selectedImage:UIImage?
    
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
        
        initViewOfTaleView()
        
        configuarator = HomeConfiguratorImpl()
        configuarator.configure(homeViewController: self)
        
        presenter.viewDidLoad(with: userSession!)
    }
    func initViewOfTaleView(){
        // Add Refesher to top of tableview
        refesher = UIRefreshControl()
        refesher!.attributedTitle = NSAttributedString(string: "Refesh tweets")
        
        refesher!.addTarget(self, action: #selector(HomeViewController.reloadTimeline), for: UIControlEvents.valueChanged)
        tweetTableView.addSubview(refesher!)
        
        // Add spinner to bottom of table view
        spinnerLoadMore.color = UIColor.darkGray
        spinnerLoadMore.hidesWhenStopped = true
        tweetTableView.tableFooterView = spinnerLoadMore
        
        tweetTableView.isHidden = true
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.rowHeight = 189
        
        // change size of header of tableview
//        var frame = tweetTableView.tableHeaderView?.frame
//        frame?.size.height = 5
//        tweetTableView.tableHeaderView?.frame = frame!
        
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
        presenter.refeshTimeline(count: UInt(countOfFirstTweets * loadCount))
        lastIndexTableViewCell += countOfFirstTweets
    }
    @objc func reloadTimeline(){
        DispatchQueue.main.async {
            self.presenter.refeshTimeline(count: UInt(self.countOfFirstTweets))
        }
      
    }
    
    
}

//MARK: - TWEET Tableview datasource and delegate
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = tweetModelArray?.count{
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = tweetModelArray![indexPath.section]
        
        // change size of cell if it has photo
        if tweet.TweetPhotoURLStringArray!.count > 0{
            
            return 400
            
        }
        return 190
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetTableViewCell", for: indexPath) as! TweetTableViewCell
        let model = tweetModelArray![indexPath.section]
        
        if model.TweetPhotoURLStringArray!.count > 0{
             cell.photoCollectionView.isHidden = false
           
        }else{
             cell.photoCollectionView.isHidden = true
        }

        
        cell.configureItem(model: model)
        print("table cell:\(indexPath.section)")
        
        // DispatchQueue.main.async make this to make collectionview preload data work properly
        DispatchQueue.main.async {
             cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
        
        
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: cell.contentView.frame.size.height - width, width:  cell.contentView.frame.size.width, height: cell.contentView.frame.size.height)
//
//        border.borderWidth = width
//        cell.contentView.layer.addSublayer(border)
//        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section + 1 == lastIndexTableViewCell{
            spinnerLoadMore.startAnimating()
           loadCount = loadCount + 1
           
                self.loadMoreTimeline()
           
           
       }
        print("last index table view cell:\(lastIndexTableViewCell)")
         print("will table cell:\(indexPath.section)")
        
        // It is important to place setCollectionViewDataSourceDelegate both willDisplay and cell Init
        guard let tableViewCell = cell as? TweetTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
}

 //MARK: - TWEET PHOTO Collectionview datasouce and delegate
extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tweetModelArray![collectionView.tag].TweetPhotoURLStringArray!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
           print("collection cell:\(indexPath.item)")


         var tweetPhotoArrayURLString:[String] = [String]()
        tweetPhotoArrayURLString = tweetModelArray![collectionView.tag].TweetPhotoURLStringArray!
        cell.configure(photoURL: tweetPhotoArrayURLString[indexPath.item])
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
//        let tweetPhotoArrayURLString = tweetModelArray![collectionView.tag].TweetPhotoURLStringArray!
//        var frame = CGRect(x: 0, y: 7.67, width: 374, height: 186)
//        if tweetPhotoArrayURLString.count > 1 {
//
//            let scrollVelocity = collectionView.panGestureRecognizer.velocity(in: collectionView)
//            if scrollVelocity.x >= 0.0 {
//                print("collectionview scroll left to right")
//                guard let previousCell = collectionView.cellForItem(at: IndexPath(item: indexPath.item-1, section: indexPath.section)) else{
//                    cell.frame = frame
//                    return
//                }
//                let previousFrame = previousCell.frame
//                frame = CGRect(x: previousFrame.maxX+5, y: previousFrame.minY, width: 372, height: 186)
//            }
//            else if scrollVelocity.x < 0.0 {
//                print("collectionview scroll right to left")
//                guard let nextCell = collectionView.cellForItem(at: IndexPath(item: indexPath.item+1, section: indexPath.section)) else{
//                    cell.frame = frame
//                    return
//                }
//                let nextFrame = nextCell.frame
//                frame = CGRect(x: nextFrame.minX-5-372, y: nextFrame.minY, width: 372, height: 186)
//            }
//
//        }
//        else{
//            frame = CGRect(x: 0, y: 7.67, width: 383, height: 186)
//        }
//         cell.frame = frame
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tweetPhotoArrayURLString = tweetModelArray![collectionView.tag].TweetPhotoURLStringArray!
        if tweetPhotoArrayURLString.count > 1{
            return CGSize(width: 350, height: 186)
        }
        return CGSize(width: 383, height: 186)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionview cell selected:\(indexPath.item)")
        
    
        
    }
}

