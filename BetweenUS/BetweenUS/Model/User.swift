//
//  User.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/03.
//

import Foundation

struct User: Codable {
    let name: String
    let nickName: String
    let birthday: String
    let content: [String]?
}
