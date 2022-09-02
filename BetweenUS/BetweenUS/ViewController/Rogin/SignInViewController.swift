//
//  SignInViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/01.
//

import UIKit
import SnapKit

final class SignInViewController: UIViewController {
    
    // MARK: - ViewProperties
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemRed
        label.text = " 이메일이 올바른 형식이 아닙니다"
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemRed
        label.text = " 비밀번호가 올바른 형식이 아닙니다"
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private let loginTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let SignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.backgroundColor = .lightGray
        
        return button
    }()
    
    private let SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.backgroundColor = .systemPink
        
        return button
    }()
    
    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfLoginTextFieldStackView()
        setConstraintsOfLoginButtonStackView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        SignInButton.layer.cornerRadius = SignInButton.frame.height / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.height / 2
    }
    
    // MARK: - Binding
    
    
    // MARK: - UI
    private func configureSubViews() {
        [loginTextFieldStackView, loginButtonStackView].forEach {
            view.addSubview($0)
        }
        
        [emailTextField, emailValidLabel,
         passwordTextField, passwordValidLabel].forEach {
            loginTextFieldStackView.addArrangedSubview($0)
        }
        
        [SignInButton, SignUpButton].forEach {
            loginButtonStackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraintsOfLoginTextFieldStackView() {
        loginTextFieldStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    private func setConstraintsOfLoginButtonStackView() {
        loginButtonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.top.equalTo(loginTextFieldStackView.snp.bottom).offset(100)
        }
    }
}
