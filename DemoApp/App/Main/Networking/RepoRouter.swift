//
//  RepoRouter.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import Alamofire

enum RepoRouter {
    case repositories
    case repositoriesDetails(id: Int)
}


extension RepoRouter: APIRouter {
    
    var method: HTTPMethod {
        switch self {
        case .repositories:
            return .get
            
        case .repositoriesDetails:
            return .get
        }
    }
    
    
    var path: ServerPath {
        switch self {
        case .repositories:
            return RepoServerPath.repositories
            
        case .repositoriesDetails(let id):
            return RepoServerPath.repositoriesDetails(id: id)
        }
    }
    
    
    var parameters: APIParameters? {
        switch self {
        case .repositories:
            return nil
            
        case .repositoriesDetails:
            return nil
        }
    }
    
}
