//
//  RepositoriesModel.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import Foundation

struct RepositoriesModel: Codable {
    var id: Int?
    var nodeId: String?
    var name: String?
    var fullName: String?
    var owner: OwnerDataModel?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case owner
    }
}


struct OwnerDataModel: Codable {
    var id: Int?
    var login: String?
    var nodeId: String?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
    }
}
