//
//  WorkSpace.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/12.
//

import UIKit

struct WorkSpace: Codable {
    let id: String
    let admin: String
    var name: String
    var userIds: [String]
    var imageUrl: String?
    var passworld: String?
    
    enum CodingKeys: String, CodingKey {
        case id, admin, name, passworld, imageUrl
        case userIds = "users"
    }
}

