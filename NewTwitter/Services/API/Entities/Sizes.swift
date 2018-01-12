//
//  Sizes.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Sizes: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let large = "large"
    static let small = "small"
    static let thumb = "thumb"
    static let medium = "medium"
  }

  // MARK: Properties
  public var large: Large?
  public var small: Small?
  public var thumb: Thumb?
  public var medium: Medium?

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
    large <- map[SerializationKeys.large]
    small <- map[SerializationKeys.small]
    thumb <- map[SerializationKeys.thumb]
    medium <- map[SerializationKeys.medium]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = large { dictionary[SerializationKeys.large] = value.dictionaryRepresentation() }
    if let value = small { dictionary[SerializationKeys.small] = value.dictionaryRepresentation() }
    if let value = thumb { dictionary[SerializationKeys.thumb] = value.dictionaryRepresentation() }
    if let value = medium { dictionary[SerializationKeys.medium] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.large = aDecoder.decodeObject(forKey: SerializationKeys.large) as? Large
    self.small = aDecoder.decodeObject(forKey: SerializationKeys.small) as? Small
    self.thumb = aDecoder.decodeObject(forKey: SerializationKeys.thumb) as? Thumb
    self.medium = aDecoder.decodeObject(forKey: SerializationKeys.medium) as? Medium
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(large, forKey: SerializationKeys.large)
    aCoder.encode(small, forKey: SerializationKeys.small)
    aCoder.encode(thumb, forKey: SerializationKeys.thumb)
    aCoder.encode(medium, forKey: SerializationKeys.medium)
  }

}
