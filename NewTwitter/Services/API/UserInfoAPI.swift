//
//  UserInfoAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/20/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import Foundation
import PromiseKit
import TwitterKit
import STTwitter
import SwiftyJSON
import ObjectMapper

class UserInfoAPI{
    static func fetchUserImage(from session:TWTRSession)->Promise<String>{
    return Promise{ fullfil, reject in
        let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
        
        twitter?.verifyCredentials(userSuccessBlock: { (userName, userID) in
            twitter?.getUsersShow(forUserID: userID, orScreenName: nil, includeEntities: nil, successBlock: { (user) in
                let userDict = user as! [String:Any]
                print(userDict)
                print(userDict["profile_image_url_https"])
                fullfil("\(userDict["profile_image_url_https"]!)")
                
            }, errorBlock: { (error) in
                reject(error!)
            })
        }, errorBlock: { (error) in
            reject(error!)
        })
        
    }
    }
    
    static func fetchUserInfo(from session:TWTRSession)->Promise<(String,String)>{
        return Promise{ fullfil, reject in
            let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
           
            twitter?.verifyCredentials(userSuccessBlock: { (userName, userID) in
                twitter?.getUsersShow(forUserID: userID, orScreenName: nil, includeEntities: nil, successBlock: { (user) in
                    let userDict = user as! [String:Any]
                    print(userDict["profile_image_url_https"])
                    print(userDict["id_str"])
                    fullfil((userDict["id_str"] as! String,userDict["profile_image_url_https"] as! String))
                }, errorBlock: { (error) in
                    reject(error!)
                })
            }, errorBlock: { (error) in
                reject(error!)
            })
            
    }
    }
}
