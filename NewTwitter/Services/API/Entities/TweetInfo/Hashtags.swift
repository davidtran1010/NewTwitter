//
//  Hashtags.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Hashtags: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let indices = "indices"
    static let text = "text"
  }

  // MARK: Properties
  public var indices: [Int]?
  public var text: String?

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
    indices <- map[SerializationKeys.indices]
    text <- map[SerializationKeys.text]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = indices { dictionary[SerializationKeys.indices] = value }
    if let value = text { dictionary[SerializationKeys.text] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.indices = aDecoder.decodeObject(forKey: SerializationKeys.indices) as? [Int]
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(indices, forKey: SerializationKeys.indices)
    aCoder.encode(text, forKey: SerializationKeys.text)
  }

}
