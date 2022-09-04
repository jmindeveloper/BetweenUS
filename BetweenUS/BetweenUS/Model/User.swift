//
//  User.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/03.
//

import Foundation

struct User: Codable {
    var id: String
    var email: String
    var name: String
    var nickName: String
    var birthday: String
    var content: [String]?
}
