//
//  SignInViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import Foundation
import Combine

final class SignInViewModel: RoginViewModel {
    
    // MARK: - Method
    func isValidSignIn() -> AnyPublisher<Bool, Never> {
        emailValid()
            .combineLatest(passwordValid())
            .map {
                if $0.0, $0.1 {
                    return true
                } else {
                    return false
                }
            }.eraseToAnyPublisher()
    }
    
    func signIn() {
        authManager.signIn(email: email, password: password) {
            $0
        }
    }
}
