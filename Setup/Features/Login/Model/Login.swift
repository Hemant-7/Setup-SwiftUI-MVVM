//
//  Login.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//

import Foundation
struct Login: Codable {
    let id: String?
    let code: Int?
    let message: String?
    let data: LoginData?

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case message = "message"
        case code = "code"
        case data = "data"
    }
}

// MARK: - DataClass
struct LoginData: Codable {
    let id: String?
    let dataID: Int?
    let name, email, token: String?

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case dataID = "Id"
        case name = "Name"
        case email = "Email"
        case token = "Token"
    }
}
