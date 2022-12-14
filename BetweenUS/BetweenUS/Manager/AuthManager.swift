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
    
    enum AuthError: Error {
        case error(type: String, message: String)
    }
    
    static let shared = AuthManager()
    
    private init() { }
    
    private let userDb = FBUserDatabase()
    
    func isLogin() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
            return true
        }
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping ((Result<Bool, AuthError>) -> Void)
    ) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                let errorCode = (error as NSError).code
                guard let authError = self.branchError(code: errorCode) else { return }
                completion(.failure(authError))
            }
            guard let result = result else { return }
            self.userDb.loadUser(id: result.user.uid) { user in
                UserInformation.shared.user = user
                completion(.success(true))
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        user: User,
        completion: @escaping ((Result<Bool, AuthError>) -> (Void))
    ) {
        logout()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                let errorCode = (error as NSError).code
                guard let authError = self.branchError(code: errorCode) else { return }
                completion(.failure(authError))
            }
            guard let result = result else { return }
            var user = user
            user.id = result.user.uid
            self.userDb.saveNewUser(user: user)
            completion(.success(true))
        }
    }
    
    private func branchError(code: Int) -> AuthError? {
        switch code {
        case 17007:
            return .error(type: "signUp", message: "?????? ?????? ??????????????????")
        case 17011:
            return .error(type: "signIn", message: "???????????? ?????? ??????????????????")
        case 17009:
            return .error(type: "signIn", message: "??????????????? ???????????? ????????????")
        default: return nil
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("??????????????? ??????????????????")
        }
    }
}
