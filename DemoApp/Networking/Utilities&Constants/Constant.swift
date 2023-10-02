//
//  Constant.swift
//
//  Created by Mohamed Aglan®
//

import Foundation

//MARK: - Request Enums -
enum Server: String {
    case baseURL = "https://api.github.com/"
    case socketURL = "socetURL"
    case socketPort = "0000"
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case lang = "lang"
}
enum ContentType: String {
    case json = "application/json"
    case deviceType = "ios"
    case tokenBearer = "Bearer "
}

//MARK: - Response Enums -
enum APIServerResponseKey: String, Codable {
    case success
    case fail
    case unauthenticated
}

//MARK: - Errors -
enum APIErrors: String {
    case connectionError
    case canNotDecodeData
}
