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
}
