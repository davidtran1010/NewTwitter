//
//  Tweets.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Tweet: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let isQuoteStatus = "is_quote_status"
    static let source = "source"
    static let quotedStatusIdStr = "quoted_status_id_str"
    static let lang = "lang"
    static let retweetCount = "retweet_count"
    static let favorited = "favorited"
    static let id = "id"
    static let retweeted = "retweeted"
    static let text = "text"
    static let entities = "entities"
    static let user = "user"
    static let possiblySensitiveAppealable = "possibly_sensitive_appealable"
    static let retweetedStatus = "retweeted_status"
    static let favoriteCount = "favorite_count"
    static let quotedStatusId = "quoted_status_id"
    static let possiblySensitive = "possibly_sensitive"
    static let createdAt = "created_at"
    static let truncated = "truncated"
    static let extendedEntities = "extended_entities"
    static let idStr = "id_str"
    static let quotedStatus = "quoted_status"
  }

  // MARK: Properties
  public var isQuoteStatus: Bool? = false
  public var source: String?
  public var quotedStatusIdStr: String?
  public var lang: String?
  public var retweetCount: Int?
  public var favorited: Bool? = false
  public var id: Int?
  public var retweeted: Bool? = false
  public var text: String?
  public var entities: Entities?
  public var user: User?
  public var possiblySensitiveAppealable: Bool? = false
  public var retweetedStatus: RetweetedStatus?
  public var favoriteCount: Int?
  public var quotedStatusId: Int?
  public var possiblySensitive: Bool? = false
  public var createdAt: String?
  public var truncated: Bool? = false
  public var extendedEntities: ExtendedEntities?
  public var idStr: String?
  public var quotedStatus: QuotedStatus?

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
    quotedStatusIdStr <- map[SerializationKeys.quotedStatusIdStr]
    lang <- map[SerializationKeys.lang]
    retweetCount <- map[SerializationKeys.retweetCount]
    favorited <- map[SerializationKeys.favorited]
    id <- map[SerializationKeys.id]
    retweeted <- map[SerializationKeys.retweeted]
    text <- map[SerializationKeys.text]
    entities <- map[SerializationKeys.entities]
    user <- map[SerializationKeys.user]
    possiblySensitiveAppealable <- map[SerializationKeys.possiblySensitiveAppealable]
    retweetedStatus <- map[SerializationKeys.retweetedStatus]
    favoriteCount <- map[SerializationKeys.favoriteCount]
    quotedStatusId <- map[SerializationKeys.quotedStatusId]
    possiblySensitive <- map[SerializationKeys.possiblySensitive]
    createdAt <- map[SerializationKeys.createdAt]
    truncated <- map[SerializationKeys.truncated]
    extendedEntities <- map[SerializationKeys.extendedEntities]
    idStr <- map[SerializationKeys.idStr]
    quotedStatus <- map[SerializationKeys.quotedStatus]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.isQuoteStatus] = isQuoteStatus
    if let value = source { dictionary[SerializationKeys.source] = value }
    if let value = quotedStatusIdStr { dictionary[SerializationKeys.quotedStatusIdStr] = value }
    if let value = lang { dictionary[SerializationKeys.lang] = value }
    if let value = retweetCount { dictionary[SerializationKeys.retweetCount] = value }
    dictionary[SerializationKeys.favorited] = favorited
    if let value = id { dictionary[SerializationKeys.id] = value }
    dictionary[SerializationKeys.retweeted] = retweeted
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = entities { dictionary[SerializationKeys.entities] = value.dictionaryRepresentation() }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.possiblySensitiveAppealable] = possiblySensitiveAppealable
    if let value = retweetedStatus { dictionary[SerializationKeys.retweetedStatus] = value.dictionaryRepresentation() }
    if let value = favoriteCount { dictionary[SerializationKeys.favoriteCount] = value }
    if let value = quotedStatusId { dictionary[SerializationKeys.quotedStatusId] = value }
    dictionary[SerializationKeys.possiblySensitive] = possiblySensitive
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    dictionary[SerializationKeys.truncated] = truncated
    if let value = extendedEntities { dictionary[SerializationKeys.extendedEntities] = value.dictionaryRepresentation() }
    if let value = idStr { dictionary[SerializationKeys.idStr] = value }
    if let value = quotedStatus { dictionary[SerializationKeys.quotedStatus] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isQuoteStatus = aDecoder.decodeBool(forKey: SerializationKeys.isQuoteStatus)
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? String
    self.quotedStatusIdStr = aDecoder.decodeObject(forKey: SerializationKeys.quotedStatusIdStr) as? String
    self.lang = aDecoder.decodeObject(forKey: SerializationKeys.lang) as? String
    self.retweetCount = aDecoder.decodeObject(forKey: SerializationKeys.retweetCount) as? Int
    self.favorited = aDecoder.decodeBool(forKey: SerializationKeys.favorited)
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.retweeted = aDecoder.decodeBool(forKey: SerializationKeys.retweeted)
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.entities = aDecoder.decodeObject(forKey: SerializationKeys.entities) as? Entities
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.possiblySensitiveAppealable = aDecoder.decodeBool(forKey: SerializationKeys.possiblySensitiveAppealable)
    self.retweetedStatus = aDecoder.decodeObject(forKey: SerializationKeys.retweetedStatus) as? RetweetedStatus
    self.favoriteCount = aDecoder.decodeObject(forKey: SerializationKeys.favoriteCount) as? Int
    self.quotedStatusId = aDecoder.decodeObject(forKey: SerializationKeys.quotedStatusId) as? Int
    self.possiblySensitive = aDecoder.decodeBool(forKey: SerializationKeys.possiblySensitive)
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.truncated = aDecoder.decodeBool(forKey: SerializationKeys.truncated)
    self.extendedEntities = aDecoder.decodeObject(forKey: SerializationKeys.extendedEntities) as? ExtendedEntities
    self.idStr = aDecoder.decodeObject(forKey: SerializationKeys.idStr) as? String
    self.quotedStatus = aDecoder.decodeObject(forKey: SerializationKeys.quotedStatus) as? QuotedStatus
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isQuoteStatus, forKey: SerializationKeys.isQuoteStatus)
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(quotedStatusIdStr, forKey: SerializationKeys.quotedStatusIdStr)
    aCoder.encode(lang, forKey: SerializationKeys.lang)
    aCoder.encode(retweetCount, forKey: SerializationKeys.retweetCount)
    aCoder.encode(favorited, forKey: SerializationKeys.favorited)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(retweeted, forKey: SerializationKeys.retweeted)
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(entities, forKey: SerializationKeys.entities)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(possiblySensitiveAppealable, forKey: SerializationKeys.possiblySensitiveAppealable)
    aCoder.encode(retweetedStatus, forKey: SerializationKeys.retweetedStatus)
    aCoder.encode(favoriteCount, forKey: SerializationKeys.favoriteCount)
    aCoder.encode(quotedStatusId, forKey: SerializationKeys.quotedStatusId)
    aCoder.encode(possiblySensitive, forKey: SerializationKeys.possiblySensitive)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(truncated, forKey: SerializationKeys.truncated)
    aCoder.encode(extendedEntities, forKey: SerializationKeys.extendedEntities)
    aCoder.encode(idStr, forKey: SerializationKeys.idStr)
    aCoder.encode(quotedStatus, forKey: SerializationKeys.quotedStatus)
  }

}
