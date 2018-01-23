//
//  userInfoEntities.swift
//
//  Created by DavidTran on 1/23/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class userInfoEntities: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let urls = "urls"
    static let userMentions = "user_mentions"
    static let symbols = "symbols"
    static let hashtags = "hashtags"
  }

  // MARK: Properties
  public var urls: [Any]?
  public var userMentions: [Any]?
  public var symbols: [Any]?
  public var hashtags: [Any]?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    urls <- map[SerializationKeys.urls]
    userMentions <- map[SerializationKeys.userMentions]
    symbols <- map[SerializationKeys.symbols]
    hashtags <- map[SerializationKeys.hashtags]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = urls { dictionary[SerializationKeys.urls] = value }
    if let value = userMentions { dictionary[SerializationKeys.userMentions] = value }
    if let value = symbols { dictionary[SerializationKeys.symbols] = value }
    if let value = hashtags { dictionary[SerializationKeys.hashtags] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.urls = aDecoder.decodeObject(forKey: SerializationKeys.urls) as? [Any]
    self.userMentions = aDecoder.decodeObject(forKey: SerializationKeys.userMentions) as? [Any]
    self.symbols = aDecoder.decodeObject(forKey: SerializationKeys.symbols) as? [Any]
    self.hashtags = aDecoder.decodeObject(forKey: SerializationKeys.hashtags) as? [Any]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(urls, forKey: SerializationKeys.urls)
    aCoder.encode(userMentions, forKey: SerializationKeys.userMentions)
    aCoder.encode(symbols, forKey: SerializationKeys.symbols)
    aCoder.encode(hashtags, forKey: SerializationKeys.hashtags)
  }

}
