//
//  Urls.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Urls: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let displayUrl = "display_url"
    static let indices = "indices"
    static let expandedUrl = "expanded_url"
    static let url = "url"
  }

  // MARK: Properties
  public var displayUrl: String?
  public var indices: [Int]?
  public var expandedUrl: String?
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
    displayUrl <- map[SerializationKeys.displayUrl]
    indices <- map[SerializationKeys.indices]
    expandedUrl <- map[SerializationKeys.expandedUrl]
    url <- map[SerializationKeys.url]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = displayUrl { dictionary[SerializationKeys.displayUrl] = value }
    if let value = indices { dictionary[SerializationKeys.indices] = value }
    if let value = expandedUrl { dictionary[SerializationKeys.expandedUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.displayUrl = aDecoder.decodeObject(forKey: SerializationKeys.displayUrl) as? String
    self.indices = aDecoder.decodeObject(forKey: SerializationKeys.indices) as? [Int]
    self.expandedUrl = aDecoder.decodeObject(forKey: SerializationKeys.expandedUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(displayUrl, forKey: SerializationKeys.displayUrl)
    aCoder.encode(indices, forKey: SerializationKeys.indices)
    aCoder.encode(expandedUrl, forKey: SerializationKeys.expandedUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
