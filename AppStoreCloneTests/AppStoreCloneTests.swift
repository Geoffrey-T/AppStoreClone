//
//  AppStoreCloneTests.swift
//  AppStoreCloneTests
//
//  Created by geoffrey thenot on 12/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import XCTest
@testable import AppStoreClone

class AppStoreCloneTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAppInfo() {
        let client = ApptweakClient(token: "mq0mYVBzALIaZKCpbxlamir-mp0")

        let expectation = self.expectation(description: "AppInfo Request")

        client.get(AppInfoRequest(appId: 454638411), completion: { response in
            switch response {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        })

        waitForExpectations(timeout: 10) { _ in
            print("timeout")
        }
    }
}
