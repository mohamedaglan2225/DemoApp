//
//  RepoServerPath.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import Foundation

enum RepoServerPath {
    case repositories
    case repositoriesDetails(id: Int)
}


extension RepoServerPath: ServerPath {
    var value: String {
        switch self {
        case .repositories:
            return "repositories"
            
        case .repositoriesDetails(let id):
            return "repositories/\(id)"
        }
    }
}
