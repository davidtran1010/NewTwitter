//
//  HomeTimelineReponse.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class TimelineResponse: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let Tweets = "Tweets"
  }

  // MARK: Properties
  public var Tweets: [Tweet]?

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
    Tweets <- map[SerializationKeys.Tweets]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = Tweets { dictionary[SerializationKeys.Tweets] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.Tweets = aDecoder.decodeObject(forKey: SerializationKeys.Tweets) as? [Tweet]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(Tweets, forKey: SerializationKeys.Tweets)
  }

}
