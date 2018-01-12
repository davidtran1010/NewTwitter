//
//  Thumb.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Thumb: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let resize = "resize"
    static let h = "h"
    static let w = "w"
  }

  // MARK: Properties
  public var resize: String?
  public var h: Int?
  public var w: Int?

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
    resize <- map[SerializationKeys.resize]
    h <- map[SerializationKeys.h]
    w <- map[SerializationKeys.w]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = resize { dictionary[SerializationKeys.resize] = value }
    if let value = h { dictionary[SerializationKeys.h] = value }
    if let value = w { dictionary[SerializationKeys.w] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.resize = aDecoder.decodeObject(forKey: SerializationKeys.resize) as? String
    self.h = aDecoder.decodeObject(forKey: SerializationKeys.h) as? Int
    self.w = aDecoder.decodeObject(forKey: SerializationKeys.w) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(resize, forKey: SerializationKeys.resize)
    aCoder.encode(h, forKey: SerializationKeys.h)
    aCoder.encode(w, forKey: SerializationKeys.w)
  }

}
