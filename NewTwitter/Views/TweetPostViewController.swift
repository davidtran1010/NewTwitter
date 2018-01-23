//
//  TweetPostViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 1/19/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import TwitterKit

protocol TweetPostDelegate:class {
    func sendRespondPostTweetToHomeVC(isSuccess:Bool)
}

class TweetPostViewController: UIViewController,TweetPostView {
    
    var delegate:TweetPostDelegate!
    var presenter:TweetPostPresenter!
    var configurator:TweetPostConfiguarator!
    var session:TWTRSession?
    var userImageURL:String?
    var homeViewController:HomeViewController!
    
    @IBOutlet weak var UserPhoto: UIImageView!
   
    @IBOutlet weak var TweetContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator = TweetPostConfiguaratorImpl()
        configurator.configure(tweetPostViewController: self)
        
        
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.97)
//        TweetPostView.layer.cornerRadius = 10
//        UserPhoto.layer.cornerRadius = 10
//        UserPhoto.clipsToBounds = true
//        UserPhoto.sd_setImage(with: URL(string: userImageURL!)) { (image, error, cache, url) in
//            if image != nil{
//                print("owner tweet photo loaded with url:\(url?.absoluteString)")
//                
//            }
//            else{
//                print("load owner tweet photo error:\(error)")
//                print(url?.absoluteString)
//            }
//        }
        TweetContent.layer.cornerRadius = 10
        TweetContent.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        
        
        
        // Do any additional setup after loading the view.
    }

    func updateUserInfo(photo: UIImage, name: String) {
        UserPhoto.image = photo
        
    }
    
    func updateTimeLineAfterPostTweet() {
      
        self.view.removeFromSuperview()
        delegate.sendRespondPostTweetToHomeVC(isSuccess: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postTweet(_ sender: UIButton) {
        if(TweetContent.text.count > 0){
            presenter.postTweet(with: TweetContent.text, from: session!)
        }
        
        print("Post Tweet")
    }
    
    @IBAction func cancelPostTweet(_ sender: UIButton) {
     
        homeViewController.TweetPostContraint.constant = -245
        UIView.animate(withDuration: 0.5, animations: {
            self.homeViewController.view.layoutIfNeeded()
        })
        
       // self.view.superview?.alpha = 0
//        self.view.willMove(toSuperview: nil)
//
//        UIView.animate(withDuration: 0.5, delay: 0.1, options: .layoutSubviews, animations: {
//            self.view.removeFromSuperview()
//            self.removeFromParentViewController()
//        }, completion: { (isFinished) in
//
//        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
