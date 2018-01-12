//
//  HomeTimelineAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/10/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import PromiseKit
import TwitterKit
import STTwitter
import SwiftyJSON
import ObjectMapper


class HomeTimelineAPI{
static func fetchTimeline(with session: TWTRSession, count:UInt) -> Promise<[Tweet]>{
    return Promise {fulfill, reject in
        let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
        
        twitter?.verifyCredentials(userSuccessBlock: { (userName, userID) in
            twitter?.getHomeTimeline(sinceID: nil, count: count, successBlock: { (statuses) -> Void in
                let jsonArrayString  = JSON(arrayLiteral: statuses)[0].rawString(.utf8, options: [])
                let jsonObjectString = "{\"Tweets\":" + jsonArrayString! + "}"
                //let jsonArray = json.arrayObject
               
                print(jsonObjectString)
                
                let reponse:TimelineResponse = Mapper<TimelineResponse>().map(JSONString: jsonObjectString)!
                fulfill(reponse.Tweets!)
                
            }, errorBlock: { (error) in
                print(error)
                reject(error!)
            })
        }, errorBlock: { (error) in
            print(error)
            reject(error!)
        })
    }
}
}
