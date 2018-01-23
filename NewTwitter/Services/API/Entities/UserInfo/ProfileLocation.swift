//
//  ProfileLocation.swift
//
//  Created by DavidTran on 1/23/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class ProfileLocation: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let containedWithin = "contained_within"
    static let name = "name"
    static let placeType = "place_type"
    static let attributes = "attributes"
    static let id = "id"
    static let countryCode = "country_code"
    static let fullName = "full_name"
    static let url = "url"
    static let country = "country"
  }

  // MARK: Properties
  public var containedWithin: [Any]?
  public var name: String?
  public var placeType: String?
  public var attributes: Attributes?
  public var id: String?
  public var countryCode: String?
  public var fullName: String?
  public var url: String?
  public var country: String?

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
    containedWithin <- map[SerializationKeys.containedWithin]
    name <- map[SerializationKeys.name]
    placeType <- map[SerializationKeys.placeType]
    attributes <- map[SerializationKeys.attributes]
    id <- map[SerializationKeys.id]
    countryCode <- map[SerializationKeys.countryCode]
    fullName <- map[SerializationKeys.fullName]
    url <- map[SerializationKeys.url]
    country <- map[SerializationKeys.country]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = containedWithin { dictionary[SerializationKeys.containedWithin] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = placeType { dictionary[SerializationKeys.placeType] = value }
    if let value = attributes { dictionary[SerializationKeys.attributes] = value.dictionaryRepresentation() }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = countryCode { dictionary[SerializationKeys.countryCode] = value }
    if let value = fullName { dictionary[SerializationKeys.fullName] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = country { dictionary[SerializationKeys.country] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.containedWithin = aDecoder.decodeObject(forKey: SerializationKeys.containedWithin) as? [Any]
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.placeType = aDecoder.decodeObject(forKey: SerializationKeys.placeType) as? String
    self.attributes = aDecoder.decodeObject(forKey: SerializationKeys.attributes) as? Attributes
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.countryCode = aDecoder.decodeObject(forKey: SerializationKeys.countryCode) as? String
    self.fullName = aDecoder.decodeObject(forKey: SerializationKeys.fullName) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(containedWithin, forKey: SerializationKeys.containedWithin)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(placeType, forKey: SerializationKeys.placeType)
    aCoder.encode(attributes, forKey: SerializationKeys.attributes)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(countryCode, forKey: SerializationKeys.countryCode)
    aCoder.encode(fullName, forKey: SerializationKeys.fullName)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(country, forKey: SerializationKeys.country)
  }

}
