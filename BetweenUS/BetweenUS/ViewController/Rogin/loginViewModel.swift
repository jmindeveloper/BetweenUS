//
//  loginViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import Foundation
import Combine

class loginViewModel {
    
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var checkPassword = ""
    let emailValidSubject = CurrentValueSubject<Bool, Never>(false)
    let passwordValidSubject = CurrentValueSubject<Bool, Never>(false)
    let checkPasswordValidSubject = CurrentValueSubject<Bool, Never>(false)
    let authSuccessSubject = PassthroughSubject<Void, Never>()
    let authFailureSubject = PassthroughSubject<String, Never>()
    let authManager = AuthManager.shared
    
    // MARK: - Method
    func authCompletion(result: Result<Bool, AuthManager.AuthError>) {
        switch result {
        case .success(_):
            authSuccessSubject.send()
        case .failure(let error):
            if case .error(type: _, message: let message) = error {
                authFailureSubject.send(message)
            }
        }
    }
    
    func emailValid() -> AnyPublisher<Bool, Never> {
        $email
            .map { [weak self] in
                guard let self = self else { return false }
                let valid = self.validateEmail(email: $0)
                self.emailValidSubject.send(valid)
                
                return valid
            }
            .eraseToAnyPublisher()
    }
    
    func passwordValid() -> AnyPublisher<Bool, Never> {
        $password
            .map { [weak self] in
                guard let self = self else { return false }
                let valid = self.validatePassword(password: $0)
                self.passwordValidSubject.send(valid)
                
                return valid
            }.eraseToAnyPublisher()
    }
    
    func checkPasswordValid() -> AnyPublisher<Bool, Never> {
        $checkPassword
            .map { [weak self] checkPassword -> Bool in
                if self?.password == checkPassword {
                    self?.checkPasswordValidSubject.send(true)
                    return true
                } else {
                    self?.checkPasswordValidSubject.send(false)
                    return false
                }
            }.eraseToAnyPublisher()
    }
    
    private func validateEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCondition = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return emailCondition.evaluate(with: email)
    }
    
    private func validatePassword(password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9]).{7,50}"
        let passwordCondition = NSPredicate(format: "SELF MATCHES %@", regex)
        
        let valid = passwordCondition.evaluate(with: password)
        return valid
    }
}
