//
//  ApptweakClient.swift
//  AppStoreClone
//
//  Created by geoffrey on 13/11/2018.
//  Copyright © 2018 ws. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public enum httpMethod: String {
    case get = "GET"
    case post = "POST"
}

public typealias ResultCompletion<Value> = (Result<Value>) -> Void

public protocol Request: Encodable {
    associatedtype Response: Decodable

    var endpointName: String { get }
}

public struct ApptweakReponse<Response: Decodable>: Decodable {
    public let status: String?

    /// Requested data
    public let data: Response?
}

class ApptweakClient {

    enum Errors: Error {
        case unkownURL
        case decodeResponse
    }

    struct HeaderKeys {
        static let token = "X-Apptweak-Key"
    }

    private let baseEndpointUrl = URL(string: "https://api.apptweak.com/")!
    private let session = URLSession(configuration: .default)

    private let token: String

    public init(token: String) {
        self.token = token
    }

    public func get<T: Request>(_ request: T, completion: @escaping ResultCompletion<T.Response>) {
        do {
            let url = try self.endpoint(for: request)

            let task = session.dataTask(with: buildUrlRequest(for: url, method: .get)) { data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(ApptweakReponse<T.Response>.self, from: data)
                        if let data = response.data {
                            completion(.success(data))
                        } else {
                            completion(.failure(Errors.decodeResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }

    private func buildUrlRequest(for url: URL, method: httpMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(token, forHTTPHeaderField: HeaderKeys.token)

        return request
    }

    private func endpoint<T: Request>(for request: T) throws -> URL {
        // Construct URL
        guard let baseUrl = URL(string: request.endpointName, relativeTo: baseEndpointUrl) else {
            throw Errors.unkownURL
        }

        var urlComponent = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)


        let parameters = [
            "country": "fr",
            "language": "fr",
            "device": "iphone"
        ]

        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        urlComponent?.queryItems = queryItems

        guard let url = urlComponent?.url else {
            throw Errors.unkownURL
        }

        return url
    }
}
