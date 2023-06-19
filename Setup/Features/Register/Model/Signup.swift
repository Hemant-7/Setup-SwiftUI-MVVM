//
//  Signup.swift
//  Setup
//
//  Created by Hemant kumar on 18/06/23.
//

import Foundation

struct Signup: Codable {
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
