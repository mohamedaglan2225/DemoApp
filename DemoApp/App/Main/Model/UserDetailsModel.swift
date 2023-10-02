//
//  UserDetailsModel.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import Foundation

struct UserDetailsModel: Codable {
    
    var avatarUrl: String?
    var name:String?
    var company: String?
    var location: String?
    var email: String?
    var twitterUsername: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case company
        case location
        case email
        case twitterUsername = "twitter_username"
        case avatarUrl = "avatar_url"
    }
    
}
