//
//  Variants.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Variants: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let bitrate = "bitrate"
    static let contentType = "content_type"
    static let url = "url"
  }

  // MARK: Properties
  public var bitrate: Int?
  public var contentType: String?
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
    bitrate <- map[SerializationKeys.bitrate]
    contentType <- map[SerializationKeys.contentType]
    url <- map[SerializationKeys.url]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = bitrate { dictionary[SerializationKeys.bitrate] = value }
    if let value = contentType { dictionary[SerializationKeys.contentType] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.bitrate = aDecoder.decodeObject(forKey: SerializationKeys.bitrate) as? Int
    self.contentType = aDecoder.decodeObject(forKey: SerializationKeys.contentType) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(bitrate, forKey: SerializationKeys.bitrate)
    aCoder.encode(contentType, forKey: SerializationKeys.contentType)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
