//
//  UserModel.swift
//
//  Created by Mohamed Aglan®
//

import Foundation

struct User: Codable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
