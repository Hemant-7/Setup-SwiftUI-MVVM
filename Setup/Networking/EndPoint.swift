//
//  EndPoint.swift
//  Setup
//
//  Created by Hemant kumar on 15/06/23.
//

import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

//Dummy Apis
//http://restapi.adequateshop.com/api/authaccount/registration

// Add following line if port is availbale
// components.port = 8000 / port number

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "restapi.adequateshop.com"
        components.path = "/" + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

extension EndPoint {
    
    static var login: Self {
        EndPoint(path: "api/authaccount/login")
    }
    
    static var signup: Self {
        EndPoint(path: "api/authaccount/registration")
    }
    
    static func usersList(page: Int = 1, url: String = "") -> Self {
        EndPoint(path: url, queryItems: [URLQueryItem(name: "page", value: "\(page)")])
    }
    
    static var profile: Self {
        EndPoint(path: "users")
    }
    
    static var updateProfile: Self {
        EndPoint(path: "users")
    }
    
    static var deleteUser: Self {
        EndPoint(path: "users")
    }
}
