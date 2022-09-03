//
//  AuthManager.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import Foundation
import FirebaseCore
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() { }
    
    private let userDb = FBUserDatabase()
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { [weak self] result, error in
            guard let result = result else { return }
            self?.userDb.loadUser(id: result.user.uid) { user in
                UserInformation.shared.user = user
            }
        }
    }
    
    func signUp(email: String, password: String, user: User) {
        logout()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            guard let result = result else { return }
            
            self.userDb.saveNewUser(user: user, id: result.user.uid)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("로그아웃에 실패했습니다")
        }
    }
}
