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
                print(errorCode, error.localizedDescription)
                guard let authError = self.branchError(code: errorCode) else { return }
                completion(.failure(authError))
            }
            guard let result = result else { return }
            
            self.userDb.saveNewUser(user: user, id: result.user.uid)
            completion(.success(true))
        }
    }
    
    private func branchError(code: Int) -> AuthError? {
        switch code {
        case 17007:
            return .error(type: "signUp", message: "이미 있는 이메일입니다")
        case 17011:
            return .error(type: "signIn", message: "존재하지 않는 이메일입니다")
        case 17009:
            return .error(type: "signIn", message: "비밀번호가 일치하지 않습니다")
        default: return nil
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
