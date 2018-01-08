//
//  LoginViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import UIKit
import TwitterKit
class LoginViewController: UIViewController,LoginView {
    
    var presenter:LoginPresenter!
    var configurator:LoginConfiguarator!
    var twitter = Twitter.sharedInstance()
    
    @IBOutlet weak var loginTwitterButton: TWTRLogInButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator = LoginConfiguratorImpl()
        self.configurator.configure(loginViewController: self)
    }
        
//    @IBAction func loginButtonPressed(_ sender: TWTRLogInButton) {
//
//        Twitter.sharedInstance().logIn { (session, error) in
//            if (session != nil) {
//                print("signed in goc as \(session?.userName)");
//
//                var userID: String = (session?.userID)!
//                var client = TWTRAPIClient(userID: userID)
//
//                let screen_name = session!.userName
//
//                var error : NSError?
//                let req = TWTRAPIClient().urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/statuses/user_timeline.json", parameters: nil, error: &error)
//                client.sendTwitterRequest(req, completion: { (response, data, error) in
//                    do {
//
//                        let response = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String : Any]]
//                        if response != nil {
//                            print((response! as NSArray).debugDescription)
//                        }
//                    }
//                    catch {
//                        print(error.localizedDescription)
//                    }
//                })
//
//
//            } else {
//                print("error: \(error?.localizedDescription)");
//            }
//        }
//
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLoginState(isSuccess: Bool) {
        if isSuccess == true{
            print("Login success")
            //performSegue(withIdentifier: "LoginToHomeSegue", sender: self)
        }
        
    }
    
    func displayLoginError(message: String) {
        print("\(message))")
    }
    func displayLoginInfo(info: String) {
        print("name: \(info)")
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
         presenter.loginButtonPressed()
        
    }
    @IBAction func goView(_ sender: Any) {
        performSegue(withIdentifier: "LoginToHomeSegue", sender: self)
        
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
