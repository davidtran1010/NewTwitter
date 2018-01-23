//
//  VideoInfo.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class VideoInfo: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let aspectRatio = "aspect_ratio"
    static let durationMillis = "duration_millis"
    static let variants = "variants"
  }

  // MARK: Properties
  public var aspectRatio: [Int]?
  public var durationMillis: Int?
  public var variants: [Variants]?

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
    aspectRatio <- map[SerializationKeys.aspectRatio]
    durationMillis <- map[SerializationKeys.durationMillis]
    variants <- map[SerializationKeys.variants]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = aspectRatio { dictionary[SerializationKeys.aspectRatio] = value }
    if let value = durationMillis { dictionary[SerializationKeys.durationMillis] = value }
    if let value = variants { dictionary[SerializationKeys.variants] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.aspectRatio = aDecoder.decodeObject(forKey: SerializationKeys.aspectRatio) as? [Int]
    self.durationMillis = aDecoder.decodeObject(forKey: SerializationKeys.durationMillis) as? Int
    self.variants = aDecoder.decodeObject(forKey: SerializationKeys.variants) as? [Variants]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(aspectRatio, forKey: SerializationKeys.aspectRatio)
    aCoder.encode(durationMillis, forKey: SerializationKeys.durationMillis)
    aCoder.encode(variants, forKey: SerializationKeys.variants)
  }

}
