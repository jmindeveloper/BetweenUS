//
//  SignUpViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import Foundation
import Combine

final class SignUpViewModel: loginViewModel {
    
    // MARK: - Properties
    var name = "" {
        didSet {
            notEmptyAllTextField()
        }
    }
    var nickName = ""{
        didSet {
            notEmptyAllTextField()
        }
    }
    var birthDay = ""{
        didSet {
            notEmptyAllTextField()
        }
    }
    let notEmptyAllTextFieldSubject = PassthroughSubject<Bool, Never>()
    
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
        let user = User(
            id: "",
            email: email,
            name: name,
            nickName: nickName,
            birthday: birthDay,
            betweenUsWorkSpace: nil
        )
        authManager.signUp(email: email, password: password, user: user) { [weak self] in
            self?.authCompletion(result: $0)
        }
    }
    
    private func notEmptyAllTextField() {
        if name.isEmpty || nickName.isEmpty || birthDay.isEmpty {
            notEmptyAllTextFieldSubject.send(false)
        } else {
            notEmptyAllTextFieldSubject.send(true)
        }
    }
}
