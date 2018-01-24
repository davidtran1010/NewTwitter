//
//  MainViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 1/22/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import TwitterKit
import PromiseKit

class MainContainerViewController: UIViewController {

    @IBOutlet weak var HomeView: UIView!
    @IBOutlet weak var sideMenuContraint: NSLayoutConstraint!
    var session:TWTRSession!
    var userInfo:UserInfoResponse!
    var sideMenuOpened = false
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenuSwipeToRight), name: Notification.Name("ToggleSideMenu"), object: nil)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(toggleSideMenuSwipeToRight))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(toggleSideMenuSwipeToLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        
        fetchUserInfo()
        
        // Do any additional setup after loading the view.
    }
    func initUIView(){
        
    }
    func fetchUserInfo(){
        
        firstly {
            UserInfoAPI.fetchUserInfo(from: session)
            }
            .then{ userInfo -> Void in
                self.handleFetchUserInfo(userInfo: userInfo)
            }
            
    }
    
    func handleFetchUserInfo(userInfo:UserInfoResponse){
        self.userInfo = userInfo
        self.performSegue(withIdentifier: "HomeEmbedSegue", sender: self)
        self.performSegue(withIdentifier: "SideMenuEmbedSegue", sender: self)
    }
    @objc func toggleSideMenuSwipeToLeft(){
     
        if sideMenuOpened == true{
            sideMenuOpened = false
            self.sideMenuContraint.constant = -294
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
             HomeView.isUserInteractionEnabled = true
        }
    }
    @objc func toggleSideMenuSwipeToRight(){
        if sideMenuOpened == false{
        sideMenuOpened = true
        sideMenuContraint.constant = 0
        //view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        HomeView.isUserInteractionEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeEmbedSegue" {
            if let homeVC = segue.destination as? HomeViewController{
                homeVC.userInfo = userInfo
                homeVC.userSession = session
            }
        }
        if segue.identifier == "SideMenuEmbedSegue" {
            if let sideMenuVC = segue.destination as? SideMenuTableViewController{
                sideMenuVC.userInfo = userInfo
            
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "HomeEmbedSegue" || identifier == "SideMenuEmbedSegue"{
            return false
        }
        return true
    }

}
