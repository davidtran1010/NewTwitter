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
class HomeViewController: UIViewController, HomeView,TweetPostDelegate{
   
    var lastIndexTableViewCellForTimeline = Constants.THRESHOLD_TO_LOAD_MORE
    var lastIndexTableViewCellForSearch = Constants.THRESHOLD_TO_LOAD_MORE
    var countOfFirstTweets = Constants.MAX_COUNT_OF_FIRST_TWEETS
    
    //var photoCollectionViewDataSource:PhotoCollectionViewDataSource?
    let spinnerLoadMore = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var loadCountTimeline = 1
    var loadCountSearch = 1
    var isSearching = false
    var selectedImage:UIImage?
    
    var presenter:HomePresenter!
    var configuarator: HomeConfigurator!
    var refesher: UIRefreshControl?
    
   //var userID = ""
    var userInfo:UserInfoResponse!
    
    @IBOutlet weak var TweetPostContraint: NSLayoutConstraint!
    @IBOutlet weak var tweetSearch: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var tweetTableView: UITableView!
   
    var tweetModelArray:[TweetTableViewCellModel]?
    var userSession:TWTRSession?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(self.receiveSession(_:)), name: .LoginSession, object: nil)
        
        
        initUIView()
        configuarator = HomeConfiguratorImpl()
        configuarator.configure(homeViewController: self)
        presenter.viewDidLoad(with: userSession!)
        
        
    }
//    @objc func receiveSession(_ notification:NSNotification){
//            print("receiving session...")
//            if let session = notification.userInfo?["session"] as? TWTRSession{
//                self.userSession = session
//                configuarator.configure(homeViewController: self)
//                presenter.viewDidLoad(with: userSession!)
//            }
//            else{
//                print("failed to receive session data from notification center")
//            }
//        
//        
//    }
    
    func sendRespondPostTweetToHomeVC(isSuccess: Bool) {
        if isSuccess{
            reloadTimeline()
        }
    }
    
    @objc func pressProfileImage(){
        NotificationCenter.default.post(name: Notification.Name("ToggleSideMenu"), object: nil)
    }
    @IBAction func postTweetButtonPressed(_ sender: Any) {
        presenter.TweetPostButtonPressed()
    }
    
    func initUIView(){
        
        userPhoto.layer.cornerRadius = 10
        userPhoto.clipsToBounds = true
        let imageProfileTap = UITapGestureRecognizer(target: self, action: #selector(pressProfileImage))
        userPhoto.addGestureRecognizer(imageProfileTap)
        userPhoto.isUserInteractionEnabled = true
        userPhoto.sd_setImage(with: URL(string: userInfo.profileImageUrlHttps!)) { (image, error, cache, url) in
            if image != nil{
                print("image profile is loaded with url:\(url)")
            }
            else{
                print("failed to load image profile")
            }
        }
        
        hideKeyboardWhenNotUsed()
        initSearchBar()
        initViewOfTableView()
    }
    func initSearchBar(){
//        tweetSearch.addTarget(self, action: #selector(searchTextFieldDidChange), for: .editingChanged)
        tweetSearch.delegate = self
    }
    
//    @objc func searchTextFieldDidChange(){
//        if tweetSearch.text == ""
//        {
//            tweetSearch.returnKeyType = .default;
//        }
//        else{
//            tweetSearch.returnKeyType = .search;
//            tweetSearch.re
//        }
//    }
    
    func initViewOfTableView(){
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
   
 
    func updateAfterDeleteTweet() {
        
    }
    
    func updateTableView(array: [TweetTableViewCellModel]) {
        tweetModelArray = array
        
        spinnerLoadMore.stopAnimating()
        tweetTableView.isHidden = false
        tweetTableView.reloadData()
        loadingIcon.isHidden = true
    }
//    func updateUserAccountInfo(userID: String, imageURL: String) {
//        self.userID = userID
//        userPhoto.sd_setImage(with: URL(string:imageURL)) { (image, error, cache, url) in
//            if image != nil{
//                print("user photo loaded")
//            }
//            else{
//                print("user photo failed to load")
//            }
//        }
//    }
    
    func searchTweet(with keyword:String){
        presenter.tweetSearchReturn(with: keyword, count: countOfFirstTweets)
    }
    func updateAfterLikeTweet(tweetIndex: Int) {
        tweetModelArray![tweetIndex].LikeCount = tweetModelArray![tweetIndex].LikeCount! + 1
         tweetModelArray![tweetIndex].isLiked = true
        var indexSet = IndexSet()
        indexSet.insert(tweetIndex)
        tweetTableView.reloadSections(indexSet, with: .fade)
    }
    func updateAfterUnLikeTweet(tweetIndex: Int) {
        tweetModelArray![tweetIndex].LikeCount = tweetModelArray![tweetIndex].LikeCount! - 1
        tweetModelArray![tweetIndex].isLiked = false
        var indexSet = IndexSet()
        indexSet.insert(tweetIndex)
        tweetTableView.reloadSections(indexSet, with: .fade)
    }
    func updateHomeAfterPostTweet() {
        reloadTimeline()
        scrollToTop()
    }
    func scrollToTop(){
        let indexPath = IndexPath(row: 0, section: 0)
        self.tweetTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func loadMoreTimeline(isSearching:Bool,with keyword:String){
    
        if !isSearching{
            presenter.refeshTimeline(count: UInt(countOfFirstTweets * loadCountTimeline))
            lastIndexTableViewCellForTimeline += countOfFirstTweets
        }
        else{
            presenter.tweetSearchReturn(with: keyword, count: Int(countOfFirstTweets * loadCountSearch))
             lastIndexTableViewCellForSearch += countOfFirstTweets
        }
        
    }
    @objc func reloadTimeline(){
         DispatchQueue.main.async {
            if !self.isSearching{
                self.spinnerLoadMore.isHidden = true
            self.presenter.refeshTimeline(count: UInt(self.countOfFirstTweets))
            }
            else{
                
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    func likeTweetButtonPressed(tweetIndex:Int){
        if tweetModelArray![tweetIndex].isLiked! == false{
        presenter.likeTweet(tweetID: tweetModelArray![tweetIndex].TweetID!, tweetIndex: tweetIndex)
        }
        else{
            presenter.unlikeTweet(tweetID: tweetModelArray![tweetIndex].TweetID!, tweetIndex: tweetIndex)
        }
    }
}

//MARK: - Hide keyboard when not used
extension HomeViewController{
    func hideKeyboardWhenNotUsed(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
//MARK: - UITextFieldDelegate
extension HomeViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tweetSearch{
            if(textField.text == ""){
                textField.returnKeyType = .default
            }
            textField.returnKeyType = .search
        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == tweetSearch{
            if textField.text == ""{
                  isSearching = false
            }
            else{
                  isSearching = true
            }
          
            return true
        }
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tweetSearch{
            searchTweet(with: textField.text!)
            return true
        }
        return false
    }
    
}

//MARK: - TWEET Tableview datasource and delegate
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{

    func hideTableCellAction(indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Hide") { (action, view, completeion) in
            var indexSet = IndexSet()
            let section = indexPath.section
            indexSet.insert(section)
            self.tweetTableView.beginUpdates()
            self.tweetModelArray?.remove(at: indexPath.section)
            
            self.tweetTableView.deleteSections(indexSet, with: .left)
            
            self.tweetTableView.endUpdates()
            completeion(true)
        }
        action.image = #imageLiteral(resourceName: "HideIcon")
        action.backgroundColor = UIColor.orange
        return action
    }
    func deleteTableCellAction(indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completeion) in
            var indexSet = IndexSet()
            let section = indexPath.section
            indexSet.insert(section)
            self.tweetTableView.beginUpdates()
            self.presenter.deleteTweet(tweetID: (self.tweetModelArray?[indexPath.section].TweetID)!)
            self.tweetModelArray?.remove(at: indexPath.section)
            self.tweetTableView.deleteSections(indexSet, with: .automatic)
            
            self.tweetTableView.endUpdates()
            completeion(true)
        }
        action.image = #imageLiteral(resourceName: "DeleteIcon")
        action.backgroundColor = UIColor.red
        return action
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let hide = hideTableCellAction(indexPath: indexPath)
        let delete = deleteTableCellAction(indexPath: indexPath)
        if(tweetModelArray![indexPath.section].TweetOwnerID == "\(self.userInfo.id!)"){
        return UISwipeActionsConfiguration(actions: [hide,delete])
        }
        return UISwipeActionsConfiguration(actions: [hide])
    }

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
            if tweet.TweetPhotoURLStringArray!.count == 1{
                
                let height = Int(tableView.bounds.size.width) * Int((tweet.TweetPhotoSizes?[0].thumb?.h)!)/Int((tweet.TweetPhotoSizes?[0].thumb?.w)!)
                return CGFloat(height + 150 * height/400)
            }
           
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

        cell.configureItem(homeViewController: self, model: model)
        print("table cell:\(indexPath.section)")
        
        // DispatchQueue.main.async make this to make collectionview preload data work properly
        DispatchQueue.main.async {
             cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.borderWidth = 0
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isSearching{
            isSearching = true
            print("last index table view cell:\(lastIndexTableViewCellForSearch)")
            if indexPath.section + 1 == lastIndexTableViewCellForSearch{
                loadCountSearch = loadCountSearch + 1
                 self.loadMoreTimeline(isSearching: isSearching, with: self.tweetSearch.text!)
            }
        }
        else{
            isSearching = false
            print("last index table view cell:\(lastIndexTableViewCellForTimeline)")
            
            if indexPath.section + 1 == lastIndexTableViewCellForTimeline{
                loadCountTimeline = loadCountTimeline + 1
                self.loadMoreTimeline(isSearching: isSearching, with: self.tweetSearch.text!)
            }
        }
        
        
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
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let tweetPhotoArrayURLString = tweetModelArray![collectionView.tag].TweetPhotoURLStringArray!
        let tweetPhotoSizes = tweetModelArray![collectionView.tag].TweetPhotoSizes
        if tweetPhotoSizes!.count > 1{
            return CGSize(width: 350, height: 186)
        }
        
        let height = 383 * Int((tweetPhotoSizes?[0].thumb?.h)!)/Int((tweetPhotoSizes?[0].thumb?.w)!)
        
        return CGSize(width: 383, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionview cell selected:\(indexPath.item)")
        
    
    }
    
}

