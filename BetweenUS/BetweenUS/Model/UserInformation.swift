//
//  UserInformation.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/03.
//

import Foundation

final class UserInformation {
    
    static let shared = UserInformation()
    
    var user: User?
    
    private init() { }
}
