//
//  TweetTableViewCellModel.swift
//  NewTwitter
//
//  Created by DavidTran on 1/12/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation

class TweetTableViewCellModel{
    
    var TweetID:String?
    var isLiked:Bool?
    var LikeCount: Int?
    var RetweetCount: Int?
    var ReplyCount: Int?
    var TweetOwnerPhotoURLString: String?
    var TweetOwnerName: String?
    var TweetOwnerID: String?
    var TweetPosedTime: String?
    var TweetPhotoURLStringArray: [String]?
    var TweetPhotoSizes:[Sizes]?
    var TweetContent: String?

    init(TweetID:String?,isLiked: Bool?,LikeCount: Int?, RetweetCount: Int?, ReplyCount: Int?, TweetOwnerPhotoURLString: String?, TweetOwnerName: String?,TweetOwnerID:String?, TweetPosedTime: String?,TweetPhotoURLStringArray:[String]?,TweetPhotoSizes:[Sizes], TweetContent: String?) {
    self.TweetID = TweetID
    self.isLiked = isLiked
    self.LikeCount = LikeCount
    self.RetweetCount = RetweetCount
    self.ReplyCount = ReplyCount
    self.TweetOwnerPhotoURLString = TweetOwnerPhotoURLString
    self.TweetOwnerName = TweetOwnerName
    self.TweetOwnerID = TweetOwnerID
    self.TweetPosedTime = TweetPosedTime
    self.TweetPhotoURLStringArray = TweetPhotoURLStringArray
    self.TweetPhotoSizes = TweetPhotoSizes
    self.TweetContent = TweetContent
}


}
