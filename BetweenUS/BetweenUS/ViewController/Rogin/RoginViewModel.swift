//
//  RoginViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import Foundation
import Combine

final class RoginViewModel {
    
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var checkPassword = ""
    let emailValidSubject = CurrentValueSubject<Bool, Never>(false)
    let passwordValidSubject = CurrentValueSubject<Bool, Never>(false)
    let checkPasswordValidSubject = CurrentValueSubject<Bool, Never>(false)
    private let authManager = AuthManager()
    
    // MARK: - Method
    private func emailValid() -> AnyPublisher<Bool, Never> {
        $email
            .map { [weak self] email -> Bool in
                if email.contains("@"), email.contains(".") {
                    self?.emailValidSubject.send(true)
                    return true
                } else {
                    self?.emailValidSubject.send(false)
                    return false
                }
            }.eraseToAnyPublisher()
    }
    
    private func passwordValid() -> AnyPublisher<Bool, Never> {
        $password
            .map { [weak self] password -> Bool in
                if password.count >= 7 {
                    self?.passwordValidSubject.send(true)
                    return true
                } else {
                    self?.passwordValidSubject.send(false)
                    return false
                }
            }.eraseToAnyPublisher()
    }
    
    private func checkPasswordValid() -> AnyPublisher<Bool, Never> {
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
    
    func signIn() {
        print("email: \(email), password: \(password)")
        authManager.signIn(email: email, password: password)
    }
    
    func signUp() {
        authManager.signUp(email: email, password: password)
    }
}
