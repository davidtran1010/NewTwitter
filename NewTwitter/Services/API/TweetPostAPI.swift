//
//  TweetPostAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/20/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import PromiseKit
import TwitterKit
import STTwitter
import SwiftyJSON
import ObjectMapper


class TweetPostAPI{
    static func postTweet(with content:String, from session:TWTRSession)->Promise<Bool>{
        return Promise{ fulfil, reject in
            let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
            
            twitter?.verifyCredentials(userSuccessBlock: { (userName, userId) in

                twitter?.postStatusesUpdate(content, inReplyToStatusID: nil, latitude: nil, longitude: nil, placeID: nil, displayCoordinates: nil, trimUser: nil, autoPopulateReplyMetadata: nil, excludeReplyUserIDsStrings: nil, attachmentURLString: nil, useExtendedTweetMode: nil, successBlock: { (_) in
                    fulfil(true)
                }, errorBlock: { (error) in
                    reject(error!)
                })
            }, errorBlock: { (error) in
                reject(error!)
            })
            
        }
        
    }
}
