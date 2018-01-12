//
//  TweetTableViewCellModel.swift
//  NewTwitter
//
//  Created by DavidTran on 1/12/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation

class TweetTableViewCellModel{
    var LikeCount: Int?
    var RetweetCount: Int?
    var ReplyCount: Int?
    var TweetOwnerPhotoURLString: String?
    var TweetOwnerName: String?
    var TweetPosedTime: String?
    var TweetPhotoURLStringArray: [String]?
    var TweetContent: String?

    init(LikeCount: Int?, RetweetCount: Int?, ReplyCount: Int?, TweetOwnerPhotoURLString: String?, TweetOwnerName: String?, TweetPosedTime: String?,TweetPhotoURLStringArray:[String]?, TweetContent: String?) {
    self.LikeCount = LikeCount
    self.RetweetCount = RetweetCount
    self.ReplyCount = ReplyCount
    self.TweetOwnerPhotoURLString = TweetOwnerPhotoURLString
    self.TweetOwnerName = TweetOwnerName
    self.TweetPosedTime = TweetPosedTime
    self.TweetPhotoURLStringArray = TweetPhotoURLStringArray
    self.TweetContent = TweetContent
}


}
