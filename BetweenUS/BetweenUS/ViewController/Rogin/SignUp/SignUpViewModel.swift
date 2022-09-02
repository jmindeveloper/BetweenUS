//
//  SignUpViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import Foundation
import Combine

final class SignUpViewModel: RoginViewModel {
    
    // MARK: - Method
    func isValidSignUp() -> AnyPublisher<Bool, Never> {
        emailValid() 
            .combineLatest(passwordValid(), checkPasswordValid())
            .map {
                if $0.0, $0.1, $0.2 {
                    return true
                } else {
                    return false
                }
            }.eraseToAnyPublisher()
    }
    
    func signUp() {
        authManager.signUp(email: email, password: password)
    }
}
