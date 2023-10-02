//
//  RepoDetailsModel.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import Foundation

struct RepoDetailsModel: Codable {
    var login: String?
    var id: Int
    var nodeId: String?
    var avatarUrl: String?
    var url: String?
    var name: String?
    var company: String?
    var location: String?
    var email: String?
    var createdAt: String?
    var updatedAt: String?
    var description: String?
    var language: String?
    var owner: OwnerDataModel?
    
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case url
        case name
        case language
        case owner
        case company
        case description
        case location
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
