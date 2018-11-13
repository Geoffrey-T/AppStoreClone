//
//  AppteakRequest.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//


public struct AppInfo: Decodable {
    public let id: Int

    enum CodingKeys: String, CodingKey {
        case id = "application_id"
    }
}

public struct AppInfoRequest: Request {
    public typealias Response = AppInfo

    public var endpointName: String {
        return "ios/applications/\(appId).json"
    }

    // Parameters
    private let appId: Int

    public init(appId: Int) {
        self.appId = appId
    }
}
