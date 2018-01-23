//
//  UserMentions.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class UserMentions: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let idStr = "id_str"
    static let name = "name"
    static let id = "id"
    static let screenName = "screen_name"
    static let indices = "indices"
  }

  // MARK: Properties
  public var idStr: String?
  public var name: String?
  public var id: Int?
  public var screenName: String?
  public var indices: [Int]?

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
    idStr <- map[SerializationKeys.idStr]
    name <- map[SerializationKeys.name]
    id <- map[SerializationKeys.id]
    screenName <- map[SerializationKeys.screenName]
    indices <- map[SerializationKeys.indices]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = idStr { dictionary[SerializationKeys.idStr] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = screenName { dictionary[SerializationKeys.screenName] = value }
    if let value = indices { dictionary[SerializationKeys.indices] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.idStr = aDecoder.decodeObject(forKey: SerializationKeys.idStr) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.screenName = aDecoder.decodeObject(forKey: SerializationKeys.screenName) as? String
    self.indices = aDecoder.decodeObject(forKey: SerializationKeys.indices) as? [Int]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(idStr, forKey: SerializationKeys.idStr)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(screenName, forKey: SerializationKeys.screenName)
    aCoder.encode(indices, forKey: SerializationKeys.indices)
  }

}
