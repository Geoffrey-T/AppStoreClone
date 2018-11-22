//
//  AppteakRequest.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

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

public struct TopCategoryRequest: Request {
    public typealias Response = [Store]

    public var endpointName: String {
        return "/ios/categories/6003/top.json?country=fr&language=\(language)&device=\(device)&type=grossing"
    }

    private let language: String
    private let device: String

    public init(language: String = "fr", device: String = "iphone") {
        self.device = device
        self.language = language
    }
}
