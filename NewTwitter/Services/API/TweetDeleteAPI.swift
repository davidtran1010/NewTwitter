//
//  TweetDeleteAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/21/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import Foundation
import Foundation
import PromiseKit
import TwitterKit
import STTwitter
import SwiftyJSON
import ObjectMapper

class TweetDeleteAPI{
    static func deleteStatusTweet(tweetID:String, from session:TWTRSession)-> Promise<Any>{
        return Promise{ fulfill, reject in
            print("status tweet to delete:\(tweetID)")
            let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
            twitter?.verifyCredentials(userSuccessBlock: { (userName, userId) in
                twitter?.postStatusesDestroy(tweetID, trimUser: nil, useExtendedTweetMode: nil, successBlock: { (status) in
                    print(status)
                }, errorBlock: { (error) in
                    print(error!)
                })
            }, errorBlock: { (error) in
                print(error!)
            })
        }
    }
}
