//
//  Status.swift
//
//  Created by DavidTran on 1/23/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Status: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let isQuoteStatus = "is_quote_status"
    static let source = "source"
    static let lang = "lang"
    static let favoriteCount = "favorite_count"
    static let retweetCount = "retweet_count"
    static let favorited = "favorited"
    static let id = "id"
    static let retweeted = "retweeted"
    static let text = "text"
    static let createdAt = "created_at"
    static let idStr = "id_str"
    static let truncated = "truncated"
    static let entities = "entities"
  }

  // MARK: Properties
  public var isQuoteStatus: Bool? = false
  public var source: String?
  public var lang: String?
  public var favoriteCount: Int?
  public var retweetCount: Int?
  public var favorited: Bool? = false
  public var id: Int?
  public var retweeted: Bool? = false
  public var text: String?
  public var createdAt: String?
  public var idStr: String?
  public var truncated: Bool? = false
  public var entities: Entities?

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
    isQuoteStatus <- map[SerializationKeys.isQuoteStatus]
    source <- map[SerializationKeys.source]
    lang <- map[SerializationKeys.lang]
    favoriteCount <- map[SerializationKeys.favoriteCount]
    retweetCount <- map[SerializationKeys.retweetCount]
    favorited <- map[SerializationKeys.favorited]
    id <- map[SerializationKeys.id]
    retweeted <- map[SerializationKeys.retweeted]
    text <- map[SerializationKeys.text]
    createdAt <- map[SerializationKeys.createdAt]
    idStr <- map[SerializationKeys.idStr]
    truncated <- map[SerializationKeys.truncated]
    entities <- map[SerializationKeys.entities]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.isQuoteStatus] = isQuoteStatus
    if let value = source { dictionary[SerializationKeys.source] = value }
    if let value = lang { dictionary[SerializationKeys.lang] = value }
    if let value = favoriteCount { dictionary[SerializationKeys.favoriteCount] = value }
    if let value = retweetCount { dictionary[SerializationKeys.retweetCount] = value }
    dictionary[SerializationKeys.favorited] = favorited
    if let value = id { dictionary[SerializationKeys.id] = value }
    dictionary[SerializationKeys.retweeted] = retweeted
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = idStr { dictionary[SerializationKeys.idStr] = value }
    dictionary[SerializationKeys.truncated] = truncated
    if let value = entities { dictionary[SerializationKeys.entities] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isQuoteStatus = aDecoder.decodeBool(forKey: SerializationKeys.isQuoteStatus)
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? String
    self.lang = aDecoder.decodeObject(forKey: SerializationKeys.lang) as? String
    self.favoriteCount = aDecoder.decodeObject(forKey: SerializationKeys.favoriteCount) as? Int
    self.retweetCount = aDecoder.decodeObject(forKey: SerializationKeys.retweetCount) as? Int
    self.favorited = aDecoder.decodeBool(forKey: SerializationKeys.favorited)
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.retweeted = aDecoder.decodeBool(forKey: SerializationKeys.retweeted)
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.idStr = aDecoder.decodeObject(forKey: SerializationKeys.idStr) as? String
    self.truncated = aDecoder.decodeBool(forKey: SerializationKeys.truncated)
    self.entities = aDecoder.decodeObject(forKey: SerializationKeys.entities) as? Entities
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isQuoteStatus, forKey: SerializationKeys.isQuoteStatus)
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(lang, forKey: SerializationKeys.lang)
    aCoder.encode(favoriteCount, forKey: SerializationKeys.favoriteCount)
    aCoder.encode(retweetCount, forKey: SerializationKeys.retweetCount)
    aCoder.encode(favorited, forKey: SerializationKeys.favorited)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(retweeted, forKey: SerializationKeys.retweeted)
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(idStr, forKey: SerializationKeys.idStr)
    aCoder.encode(truncated, forKey: SerializationKeys.truncated)
    aCoder.encode(entities, forKey: SerializationKeys.entities)
  }

}
