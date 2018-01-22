//
//  TweetSearchAPI.swift
//  NewTwitter
//
//  Created by DavidTran on 1/21/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import Foundation
import PromiseKit
import TwitterKit
import STTwitter
import SwiftyJSON
import ObjectMapper

class TweetSearchAPI{
    static func fetchTweetSearch(keyword:String, from session:TWTRSession,count:Int)-> Promise<[Tweet]>{
       return Promise{ fulfill, reject in
            let twitter = STTwitterAPI(oAuthConsumerKey: ApiInfo.consumerKey, consumerSecret: ApiInfo.consumerSecret, oauthToken: session.authToken, oauthTokenSecret: session .authTokenSecret)
        
        twitter?.verifyCredentials(userSuccessBlock: { (userName, userId) in
            twitter?.getSearchTweets(withQuery: keyword, geocode: nil, lang: nil, locale: nil, resultType: "mixed", count: "\(count)", until: nil, sinceID: nil, maxID: nil, includeEntities: 1, callback: nil, useExtendedTweetMode: 1, successBlock: { (metaData, statuses) in
                    let jsonArrayString  = JSON(arrayLiteral: statuses)[0].rawString(.utf8, options: [])
                    let jsonObjectString = "{\"Tweets\":" + jsonArrayString! + "}"
                    //let jsonArray = json.arrayObject
    
                    print("search result:"+jsonObjectString)
                
                    let reponse:TimelineResponse = Mapper<TimelineResponse>().map(JSONString: jsonObjectString)!
                    fulfill(reponse.Tweets!)
                
            }, errorBlock: { (error) in
                print(error)
            })
        }, errorBlock: { (error) in
            print(error!)
        })
        }
    }
}


