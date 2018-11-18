//
//  ApptweakObjects.swift
//  AppStoreClone
//
//  Created by geoffrey on 14/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import Foundation

public struct AppInfo: Decodable {
    public let id: Int
    public let rankings: [Ranking]
    public let developer: Developer
    public let storeInfo: Store

    enum CodingKeys: String, CodingKey {
        case id = "application_id"
        case rankings
        case developer
        case storeInfo = "store_info"
    }
}

public struct Ranking: Decodable {
    public let categoryId: String
    public let type: String // TODO: Enum ?
    public let endDate: String
    public let startDate: String
    public let ranks: [Int?]

    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case type
        case endDate = "end_date"
        case startDate = "start_date"
        case ranks
    }
}

public struct Developer: Decodable {
    public let id: Int
    public let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

public struct Store: Decodable {
    public let versions: [Version]
    public let icon: URL
    public let genres: [Int]
    public let title: String
    public let slug: String
    public let description: String
    public let price: String
    public let features: Features
    public let devices: [String] //TODO : enum?


    enum CodingKeys: String, CodingKey {
        case versions
        case icon
        case genres
        case title
        case slug
        case description
        case price
        case features
        case devices
    }
}

public struct Version: Decodable {
    public let version: String
    public let releaseDate: String
    public let releaseNotes: String

    enum CodingKeys: String, CodingKey {
        case version
        case releaseDate = "release_date"
        case releaseNotes = "release_notes"
    }
}

public struct Features: Decodable {
    public let gameCenter: Bool
    public let passbook: Bool
    public let inApps: Bool

    enum CodingKeys: String, CodingKey {
        case gameCenter = "game_center"
        case passbook
        case inApps = "in_apps"
    }
}

