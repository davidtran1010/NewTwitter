//
//  Media.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Media: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let mediaUrlHttps = "media_url_https"
    static let id = "id"
    static let expandedUrl = "expanded_url"
    static let mediaUrl = "media_url"
    static let idStr = "id_str"
    static let displayUrl = "display_url"
    static let type = "type"
    static let indices = "indices"
    static let sizes = "sizes"
    static let url = "url"
  }

  // MARK: Properties
  public var mediaUrlHttps: String?
  public var id: Int?
  public var expandedUrl: String?
  public var mediaUrl: String?
  public var idStr: String?
  public var displayUrl: String?
  public var type: String?
  public var indices: [Int]?
  public var sizes: Sizes?
  public var url: String?

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
    mediaUrlHttps <- map[SerializationKeys.mediaUrlHttps]
    id <- map[SerializationKeys.id]
    expandedUrl <- map[SerializationKeys.expandedUrl]
    mediaUrl <- map[SerializationKeys.mediaUrl]
    idStr <- map[SerializationKeys.idStr]
    displayUrl <- map[SerializationKeys.displayUrl]
    type <- map[SerializationKeys.type]
    indices <- map[SerializationKeys.indices]
    sizes <- map[SerializationKeys.sizes]
    url <- map[SerializationKeys.url]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = mediaUrlHttps { dictionary[SerializationKeys.mediaUrlHttps] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = expandedUrl { dictionary[SerializationKeys.expandedUrl] = value }
    if let value = mediaUrl { dictionary[SerializationKeys.mediaUrl] = value }
    if let value = idStr { dictionary[SerializationKeys.idStr] = value }
    if let value = displayUrl { dictionary[SerializationKeys.displayUrl] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = indices { dictionary[SerializationKeys.indices] = value }
    if let value = sizes { dictionary[SerializationKeys.sizes] = value.dictionaryRepresentation() }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.mediaUrlHttps = aDecoder.decodeObject(forKey: SerializationKeys.mediaUrlHttps) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.expandedUrl = aDecoder.decodeObject(forKey: SerializationKeys.expandedUrl) as? String
    self.mediaUrl = aDecoder.decodeObject(forKey: SerializationKeys.mediaUrl) as? String
    self.idStr = aDecoder.decodeObject(forKey: SerializationKeys.idStr) as? String
    self.displayUrl = aDecoder.decodeObject(forKey: SerializationKeys.displayUrl) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.indices = aDecoder.decodeObject(forKey: SerializationKeys.indices) as? [Int]
    self.sizes = aDecoder.decodeObject(forKey: SerializationKeys.sizes) as? Sizes
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(mediaUrlHttps, forKey: SerializationKeys.mediaUrlHttps)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(expandedUrl, forKey: SerializationKeys.expandedUrl)
    aCoder.encode(mediaUrl, forKey: SerializationKeys.mediaUrl)
    aCoder.encode(idStr, forKey: SerializationKeys.idStr)
    aCoder.encode(displayUrl, forKey: SerializationKeys.displayUrl)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(indices, forKey: SerializationKeys.indices)
    aCoder.encode(sizes, forKey: SerializationKeys.sizes)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
