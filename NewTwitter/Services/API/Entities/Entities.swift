//
//  Entities.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Entities: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let hashtags = "hashtags"
    static let userMentions = "user_mentions"
    static let media = "media"
    static let symbols = "symbols"
    static let urls = "urls"
  }

  // MARK: Properties
  public var hashtags: [Hashtags]?
  public var userMentions: [UserMentions]?
  public var media: [Media]?
  public var symbols: [Any]?
  public var urls: [Urls]?

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
    hashtags <- map[SerializationKeys.hashtags]
    userMentions <- map[SerializationKeys.userMentions]
    media <- map[SerializationKeys.media]
    symbols <- map[SerializationKeys.symbols]
    urls <- map[SerializationKeys.urls]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = hashtags { dictionary[SerializationKeys.hashtags] = value.map { $0.dictionaryRepresentation() } }
    if let value = userMentions { dictionary[SerializationKeys.userMentions] = value.map { $0.dictionaryRepresentation() } }
    if let value = media { dictionary[SerializationKeys.media] = value.map { $0.dictionaryRepresentation() } }
    if let value = symbols { dictionary[SerializationKeys.symbols] = value }
    if let value = urls { dictionary[SerializationKeys.urls] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.hashtags = aDecoder.decodeObject(forKey: SerializationKeys.hashtags) as? [Hashtags]
    self.userMentions = aDecoder.decodeObject(forKey: SerializationKeys.userMentions) as? [UserMentions]
    self.media = aDecoder.decodeObject(forKey: SerializationKeys.media) as? [Media]
    self.symbols = aDecoder.decodeObject(forKey: SerializationKeys.symbols) as? [Any]
    self.urls = aDecoder.decodeObject(forKey: SerializationKeys.urls) as? [Urls]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(hashtags, forKey: SerializationKeys.hashtags)
    aCoder.encode(userMentions, forKey: SerializationKeys.userMentions)
    aCoder.encode(media, forKey: SerializationKeys.media)
    aCoder.encode(symbols, forKey: SerializationKeys.symbols)
    aCoder.encode(urls, forKey: SerializationKeys.urls)
  }

}
