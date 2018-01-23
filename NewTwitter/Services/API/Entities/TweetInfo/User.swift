//
//  User.swift
//
//  Created by DavidTran on 1/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class User: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let timeZone = "time_zone"
    static let protected = "protected"
    static let profileSidebarBorderColor = "profile_sidebar_border_color"
    static let profileLinkColor = "profile_link_color"
    static let lang = "lang"
    static let favouritesCount = "favourites_count"
    static let defaultProfileImage = "default_profile_image"
    static let profileBackgroundColor = "profile_background_color"
    static let profileSidebarFillColor = "profile_sidebar_fill_color"
    static let profileBackgroundTile = "profile_background_tile"
    static let isTranslator = "is_translator"
    static let isTranslationEnabled = "is_translation_enabled"
    static let profileImageUrlHttps = "profile_image_url_https"
    static let friendsCount = "friends_count"
    static let id = "id"
    static let entities = "entities"
    static let profileBackgroundImageUrlHttps = "profile_background_image_url_https"
    static let following = "following"
    static let utcOffset = "utc_offset"
    static let profileImageUrl = "profile_image_url"
    static let url = "url"
    static let statusesCount = "statuses_count"
    static let defaultProfile = "default_profile"
    static let listedCount = "listed_count"
    static let name = "name"
    static let geoEnabled = "geo_enabled"
    static let profileUseBackgroundImage = "profile_use_background_image"
    static let screenName = "screen_name"
    static let descriptionValue = "description"
    static let notifications = "notifications"
    static let contributorsEnabled = "contributors_enabled"
    static let hasExtendedProfile = "has_extended_profile"
    static let followersCount = "followers_count"
    static let verified = "verified"
    static let location = "location"
    static let createdAt = "created_at"
    static let followRequestSent = "follow_request_sent"
    static let idStr = "id_str"
    static let profileBannerUrl = "profile_banner_url"
    static let profileBackgroundImageUrl = "profile_background_image_url"
    static let profileTextColor = "profile_text_color"
    static let translatorType = "translator_type"
  }

  // MARK: Properties
  public var timeZone: String?
  public var protected: Bool? = false
  public var profileSidebarBorderColor: String?
  public var profileLinkColor: String?
  public var lang: String?
  public var favouritesCount: Int?
  public var defaultProfileImage: Bool? = false
  public var profileBackgroundColor: String?
  public var profileSidebarFillColor: String?
  public var profileBackgroundTile: Bool? = false
  public var isTranslator: Bool? = false
  public var isTranslationEnabled: Bool? = false
  public var profileImageUrlHttps: String?
  public var friendsCount: Int?
  public var id: Int?
  public var entities: userEntities?
  public var profileBackgroundImageUrlHttps: String?
  public var following: Bool? = false
  public var utcOffset: Int?
  public var profileImageUrl: String?
  public var url: String?
  public var statusesCount: Int?
  public var defaultProfile: Bool? = false
  public var listedCount: Int?
  public var name: String?
  public var geoEnabled: Bool? = false
  public var profileUseBackgroundImage: Bool? = false
  public var screenName: String?
  public var descriptionValue: String?
  public var notifications: Bool? = false
  public var contributorsEnabled: Bool? = false
  public var hasExtendedProfile: Bool? = false
  public var followersCount: Int?
  public var verified: Bool? = false
  public var location: String?
  public var createdAt: String?
  public var followRequestSent: Bool? = false
  public var idStr: String?
  public var profileBannerUrl: String?
  public var profileBackgroundImageUrl: String?
  public var profileTextColor: String?
  public var translatorType: String?

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
    timeZone <- map[SerializationKeys.timeZone]
    protected <- map[SerializationKeys.protected]
    profileSidebarBorderColor <- map[SerializationKeys.profileSidebarBorderColor]
    profileLinkColor <- map[SerializationKeys.profileLinkColor]
    lang <- map[SerializationKeys.lang]
    favouritesCount <- map[SerializationKeys.favouritesCount]
    defaultProfileImage <- map[SerializationKeys.defaultProfileImage]
    profileBackgroundColor <- map[SerializationKeys.profileBackgroundColor]
    profileSidebarFillColor <- map[SerializationKeys.profileSidebarFillColor]
    profileBackgroundTile <- map[SerializationKeys.profileBackgroundTile]
    isTranslator <- map[SerializationKeys.isTranslator]
    isTranslationEnabled <- map[SerializationKeys.isTranslationEnabled]
    profileImageUrlHttps <- map[SerializationKeys.profileImageUrlHttps]
    friendsCount <- map[SerializationKeys.friendsCount]
    id <- map[SerializationKeys.id]
    entities <- map[SerializationKeys.entities]
    profileBackgroundImageUrlHttps <- map[SerializationKeys.profileBackgroundImageUrlHttps]
    following <- map[SerializationKeys.following]
    utcOffset <- map[SerializationKeys.utcOffset]
    profileImageUrl <- map[SerializationKeys.profileImageUrl]
    url <- map[SerializationKeys.url]
    statusesCount <- map[SerializationKeys.statusesCount]
    defaultProfile <- map[SerializationKeys.defaultProfile]
    listedCount <- map[SerializationKeys.listedCount]
    name <- map[SerializationKeys.name]
    geoEnabled <- map[SerializationKeys.geoEnabled]
    profileUseBackgroundImage <- map[SerializationKeys.profileUseBackgroundImage]
    screenName <- map[SerializationKeys.screenName]
    descriptionValue <- map[SerializationKeys.descriptionValue]
    notifications <- map[SerializationKeys.notifications]
    contributorsEnabled <- map[SerializationKeys.contributorsEnabled]
    hasExtendedProfile <- map[SerializationKeys.hasExtendedProfile]
    followersCount <- map[SerializationKeys.followersCount]
    verified <- map[SerializationKeys.verified]
    location <- map[SerializationKeys.location]
    createdAt <- map[SerializationKeys.createdAt]
    followRequestSent <- map[SerializationKeys.followRequestSent]
    idStr <- map[SerializationKeys.idStr]
    profileBannerUrl <- map[SerializationKeys.profileBannerUrl]
    profileBackgroundImageUrl <- map[SerializationKeys.profileBackgroundImageUrl]
    profileTextColor <- map[SerializationKeys.profileTextColor]
    translatorType <- map[SerializationKeys.translatorType]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = timeZone { dictionary[SerializationKeys.timeZone] = value }
    dictionary[SerializationKeys.protected] = protected
    if let value = profileSidebarBorderColor { dictionary[SerializationKeys.profileSidebarBorderColor] = value }
    if let value = profileLinkColor { dictionary[SerializationKeys.profileLinkColor] = value }
    if let value = lang { dictionary[SerializationKeys.lang] = value }
    if let value = favouritesCount { dictionary[SerializationKeys.favouritesCount] = value }
    dictionary[SerializationKeys.defaultProfileImage] = defaultProfileImage
    if let value = profileBackgroundColor { dictionary[SerializationKeys.profileBackgroundColor] = value }
    if let value = profileSidebarFillColor { dictionary[SerializationKeys.profileSidebarFillColor] = value }
    dictionary[SerializationKeys.profileBackgroundTile] = profileBackgroundTile
    dictionary[SerializationKeys.isTranslator] = isTranslator
    dictionary[SerializationKeys.isTranslationEnabled] = isTranslationEnabled
    if let value = profileImageUrlHttps { dictionary[SerializationKeys.profileImageUrlHttps] = value }
    if let value = friendsCount { dictionary[SerializationKeys.friendsCount] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = entities { dictionary[SerializationKeys.entities] = value.dictionaryRepresentation() }
    if let value = profileBackgroundImageUrlHttps { dictionary[SerializationKeys.profileBackgroundImageUrlHttps] = value }
    dictionary[SerializationKeys.following] = following
    if let value = utcOffset { dictionary[SerializationKeys.utcOffset] = value }
    if let value = profileImageUrl { dictionary[SerializationKeys.profileImageUrl] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = statusesCount { dictionary[SerializationKeys.statusesCount] = value }
    dictionary[SerializationKeys.defaultProfile] = defaultProfile
    if let value = listedCount { dictionary[SerializationKeys.listedCount] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    dictionary[SerializationKeys.geoEnabled] = geoEnabled
    dictionary[SerializationKeys.profileUseBackgroundImage] = profileUseBackgroundImage
    if let value = screenName { dictionary[SerializationKeys.screenName] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    dictionary[SerializationKeys.notifications] = notifications
    dictionary[SerializationKeys.contributorsEnabled] = contributorsEnabled
    dictionary[SerializationKeys.hasExtendedProfile] = hasExtendedProfile
    if let value = followersCount { dictionary[SerializationKeys.followersCount] = value }
    dictionary[SerializationKeys.verified] = verified
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    dictionary[SerializationKeys.followRequestSent] = followRequestSent
    if let value = idStr { dictionary[SerializationKeys.idStr] = value }
    if let value = profileBannerUrl { dictionary[SerializationKeys.profileBannerUrl] = value }
    if let value = profileBackgroundImageUrl { dictionary[SerializationKeys.profileBackgroundImageUrl] = value }
    if let value = profileTextColor { dictionary[SerializationKeys.profileTextColor] = value }
    if let value = translatorType { dictionary[SerializationKeys.translatorType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.timeZone = aDecoder.decodeObject(forKey: SerializationKeys.timeZone) as? String
    self.protected = aDecoder.decodeBool(forKey: SerializationKeys.protected)
    self.profileSidebarBorderColor = aDecoder.decodeObject(forKey: SerializationKeys.profileSidebarBorderColor) as? String
    self.profileLinkColor = aDecoder.decodeObject(forKey: SerializationKeys.profileLinkColor) as? String
    self.lang = aDecoder.decodeObject(forKey: SerializationKeys.lang) as? String
    self.favouritesCount = aDecoder.decodeObject(forKey: SerializationKeys.favouritesCount) as? Int
    self.defaultProfileImage = aDecoder.decodeBool(forKey: SerializationKeys.defaultProfileImage)
    self.profileBackgroundColor = aDecoder.decodeObject(forKey: SerializationKeys.profileBackgroundColor) as? String
    self.profileSidebarFillColor = aDecoder.decodeObject(forKey: SerializationKeys.profileSidebarFillColor) as? String
    self.profileBackgroundTile = aDecoder.decodeBool(forKey: SerializationKeys.profileBackgroundTile)
    self.isTranslator = aDecoder.decodeBool(forKey: SerializationKeys.isTranslator)
    self.isTranslationEnabled = aDecoder.decodeBool(forKey: SerializationKeys.isTranslationEnabled)
    self.profileImageUrlHttps = aDecoder.decodeObject(forKey: SerializationKeys.profileImageUrlHttps) as? String
    self.friendsCount = aDecoder.decodeObject(forKey: SerializationKeys.friendsCount) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.entities = aDecoder.decodeObject(forKey: SerializationKeys.entities) as? userEntities
    self.profileBackgroundImageUrlHttps = aDecoder.decodeObject(forKey: SerializationKeys.profileBackgroundImageUrlHttps) as? String
    self.following = aDecoder.decodeBool(forKey: SerializationKeys.following)
    self.utcOffset = aDecoder.decodeObject(forKey: SerializationKeys.utcOffset) as? Int
    self.profileImageUrl = aDecoder.decodeObject(forKey: SerializationKeys.profileImageUrl) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.statusesCount = aDecoder.decodeObject(forKey: SerializationKeys.statusesCount) as? Int
    self.defaultProfile = aDecoder.decodeBool(forKey: SerializationKeys.defaultProfile)
    self.listedCount = aDecoder.decodeObject(forKey: SerializationKeys.listedCount) as? Int
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.geoEnabled = aDecoder.decodeBool(forKey: SerializationKeys.geoEnabled)
    self.profileUseBackgroundImage = aDecoder.decodeBool(forKey: SerializationKeys.profileUseBackgroundImage)
    self.screenName = aDecoder.decodeObject(forKey: SerializationKeys.screenName) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.notifications = aDecoder.decodeBool(forKey: SerializationKeys.notifications)
    self.contributorsEnabled = aDecoder.decodeBool(forKey: SerializationKeys.contributorsEnabled)
    self.hasExtendedProfile = aDecoder.decodeBool(forKey: SerializationKeys.hasExtendedProfile)
    self.followersCount = aDecoder.decodeObject(forKey: SerializationKeys.followersCount) as? Int
    self.verified = aDecoder.decodeBool(forKey: SerializationKeys.verified)
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.followRequestSent = aDecoder.decodeBool(forKey: SerializationKeys.followRequestSent)
    self.idStr = aDecoder.decodeObject(forKey: SerializationKeys.idStr) as? String
    self.profileBannerUrl = aDecoder.decodeObject(forKey: SerializationKeys.profileBannerUrl) as? String
    self.profileBackgroundImageUrl = aDecoder.decodeObject(forKey: SerializationKeys.profileBackgroundImageUrl) as? String
    self.profileTextColor = aDecoder.decodeObject(forKey: SerializationKeys.profileTextColor) as? String
    self.translatorType = aDecoder.decodeObject(forKey: SerializationKeys.translatorType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(timeZone, forKey: SerializationKeys.timeZone)
    aCoder.encode(protected, forKey: SerializationKeys.protected)
    aCoder.encode(profileSidebarBorderColor, forKey: SerializationKeys.profileSidebarBorderColor)
    aCoder.encode(profileLinkColor, forKey: SerializationKeys.profileLinkColor)
    aCoder.encode(lang, forKey: SerializationKeys.lang)
    aCoder.encode(favouritesCount, forKey: SerializationKeys.favouritesCount)
    aCoder.encode(defaultProfileImage, forKey: SerializationKeys.defaultProfileImage)
    aCoder.encode(profileBackgroundColor, forKey: SerializationKeys.profileBackgroundColor)
    aCoder.encode(profileSidebarFillColor, forKey: SerializationKeys.profileSidebarFillColor)
    aCoder.encode(profileBackgroundTile, forKey: SerializationKeys.profileBackgroundTile)
    aCoder.encode(isTranslator, forKey: SerializationKeys.isTranslator)
    aCoder.encode(isTranslationEnabled, forKey: SerializationKeys.isTranslationEnabled)
    aCoder.encode(profileImageUrlHttps, forKey: SerializationKeys.profileImageUrlHttps)
    aCoder.encode(friendsCount, forKey: SerializationKeys.friendsCount)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(entities, forKey: SerializationKeys.entities)
    aCoder.encode(profileBackgroundImageUrlHttps, forKey: SerializationKeys.profileBackgroundImageUrlHttps)
    aCoder.encode(following, forKey: SerializationKeys.following)
    aCoder.encode(utcOffset, forKey: SerializationKeys.utcOffset)
    aCoder.encode(profileImageUrl, forKey: SerializationKeys.profileImageUrl)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(statusesCount, forKey: SerializationKeys.statusesCount)
    aCoder.encode(defaultProfile, forKey: SerializationKeys.defaultProfile)
    aCoder.encode(listedCount, forKey: SerializationKeys.listedCount)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(geoEnabled, forKey: SerializationKeys.geoEnabled)
    aCoder.encode(profileUseBackgroundImage, forKey: SerializationKeys.profileUseBackgroundImage)
    aCoder.encode(screenName, forKey: SerializationKeys.screenName)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(notifications, forKey: SerializationKeys.notifications)
    aCoder.encode(contributorsEnabled, forKey: SerializationKeys.contributorsEnabled)
    aCoder.encode(hasExtendedProfile, forKey: SerializationKeys.hasExtendedProfile)
    aCoder.encode(followersCount, forKey: SerializationKeys.followersCount)
    aCoder.encode(verified, forKey: SerializationKeys.verified)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(followRequestSent, forKey: SerializationKeys.followRequestSent)
    aCoder.encode(idStr, forKey: SerializationKeys.idStr)
    aCoder.encode(profileBannerUrl, forKey: SerializationKeys.profileBannerUrl)
    aCoder.encode(profileBackgroundImageUrl, forKey: SerializationKeys.profileBackgroundImageUrl)
    aCoder.encode(profileTextColor, forKey: SerializationKeys.profileTextColor)
    aCoder.encode(translatorType, forKey: SerializationKeys.translatorType)
  }

}
