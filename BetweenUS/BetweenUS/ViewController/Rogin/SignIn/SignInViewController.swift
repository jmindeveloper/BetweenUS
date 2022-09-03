//
//  SignInViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/01.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class SignInViewController: UIViewController {
    
    // MARK: - ViewProperties
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.borderStyle = .roundedRect
        textField.configure()
        
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
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.configure()
        textField.isSecureTextEntry = true
        
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
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        
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
    
    // MARK: - Properties
    private let viewModel = SignInViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfLoginTextFieldStackView()
        setConstraintsOfLoginButtonStackView()
        
        bindingViewModel()
        bindingViewProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.height / 2
    }
    
    // MARK: - Method
    private func presentSignUpViewController() {
        let signUpVC = SignUpViewController()
        let navigationVC = UINavigationController(rootViewController: signUpVC)
        navigationVC.modalPresentationStyle = .overFullScreen
        present(navigationVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Binding
    private func bindingViewModel() {
        viewModel.isValidSignIn()
            .sink { [weak self] isValid in
                self?.signInButton.isEnabled = isValid
                self?.signInButton.backgroundColor = isValid ? .orange : .lightGray
            }.store(in: &subscriptions)
        
        viewModel.emailValidSubject
            .sink { [weak self] isValid in
                self?.emailValidLabel.text = isValid ? " " : " 이메일이 올바른 형식이 아닙니다"
            }.store(in: &subscriptions)
        
        viewModel.passwordValidSubject
            .sink { [weak self] isValid in
                self?.passwordValidLabel.text = isValid ? " " : " 비밀번호가 올바른 형식이 아닙니다"
            }.store(in: &subscriptions)
        
        viewModel.authSuccessSubject
            .sink { [weak self] in
                print("로그인 성공")
            }.store(in: &subscriptions)
        
        viewModel.authFailureSubject
            .sink { [weak self] errorMessage in
                print("로그인 실패: ", errorMessage)
            }.store(in: &subscriptions)
    }
    
    private func bindingViewProperties() {
        emailTextField.textPublisher
            .sink { [weak self] text in
                guard let text = text else {
                    return
                }
                self?.viewModel.email = text
            }.store(in: &subscriptions)
        
        passwordTextField.textPublisher
            .sink { [weak self] text in
                guard let text = text else {
                    return
                }
                self?.viewModel.password = text
            }.store(in: &subscriptions)
        
        signInButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.signIn()
            }.store(in: &subscriptions)
        
        SignUpButton.tapPublisher
            .sink { [weak self] in
                self?.presentSignUpViewController()
            }.store(in: &subscriptions)
    }
    
    // MARK: - UI
    private func configureSubViews() {
        [loginTextFieldStackView, loginButtonStackView].forEach {
            view.addSubview($0)
        }
        
        [emailTextField, emailValidLabel,
         passwordTextField, passwordValidLabel].forEach {
            loginTextFieldStackView.addArrangedSubview($0)
        }
        
        [signInButton, SignUpButton].forEach {
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
