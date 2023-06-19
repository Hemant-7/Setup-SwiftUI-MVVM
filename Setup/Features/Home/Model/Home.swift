//
//  Home.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//

import Foundation

struct Users: Codable {
    let id: String?
    let page, perPage, totalrecord, totalPages: Int?
    let data: [UserData]?
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case page = "page"
        case perPage = "per_page"
        case totalrecord = "totalrecord"
        case totalPages = "total_pages"
        case data = "data"
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id: String?
    let dataID: Int?
    let name, email: String?
    let profilepicture: String?
    let location, createdat: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case dataID = "id"
        case name = "name"
        case email = "email"
        case profilepicture = "profilepicture"
        case location = "location"
        case createdat = "createdat"
    }
}
