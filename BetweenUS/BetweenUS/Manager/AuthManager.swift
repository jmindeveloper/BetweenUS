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
    let handler = Auth.auth().addStateDidChangeListener { auth, user in
        print("auth: ", auth, "user: ", user?.uid)
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(handler)
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { [weak self] result, error in
            print("signInResult: ", result)
            print("error: ", error)
        }
    }
    
    func signUp(email: String, password: String) {
        logout()
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            print("result: ", result, "error: ", error)
        }
    }
    
    func logout() {
        try! Auth.auth().signOut()
    }
}
