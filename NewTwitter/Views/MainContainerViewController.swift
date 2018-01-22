//
//  MainViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 1/22/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import TwitterKit
class MainContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuContraint: NSLayoutConstraint!
    var session:TWTRSession!
    var sideMenuOpened = false
    
    @objc func toggleSideMenu(){
        if sideMenuOpened{
            sideMenuOpened = false
            DispatchQueue.main.async {
                self.sideMenuContraint.constant = -294
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            }
        }else{
            sideMenuOpened = true
            
            sideMenuContraint.constant = 0
            //view.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: Notification.Name("ToggleSideMenu"), object: nil)
        // Do any additional setup after loading the view.
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
                homeVC.userSession = session
            }
        }
    }
    

}
