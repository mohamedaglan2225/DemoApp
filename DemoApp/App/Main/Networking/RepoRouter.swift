//
//  RepoRouter.swift
//  DemoApp
//
//  Created by Mohamed Aglan on 10/2/23.
//

import Alamofire

enum RepoRouter {
    case repositories
}


extension RepoRouter: APIRouter {
    
    var method: HTTPMethod {
        switch self {
        case .repositories:
            return .get
        }
    }
    
    
    var path: ServerPath {
        switch self {
        case .repositories:
            return RepoServerPath.repositories
        }
    }
    
    
    var parameters: APIParameters? {
        switch self {
        case .repositories:
            return nil
        }
    }
    
}
