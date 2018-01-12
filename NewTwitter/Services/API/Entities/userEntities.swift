//
//  userEntities.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class userEntities: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descriptionValue = "description"
    static let url = "url"
  }

  // MARK: Properties
  public var descriptionValue: DescriptionValue?
  public var url: Url?

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
    descriptionValue <- map[SerializationKeys.descriptionValue]
    url <- map[SerializationKeys.url]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value.dictionaryRepresentation() }
    if let value = url { dictionary[SerializationKeys.url] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? DescriptionValue
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? Url
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
