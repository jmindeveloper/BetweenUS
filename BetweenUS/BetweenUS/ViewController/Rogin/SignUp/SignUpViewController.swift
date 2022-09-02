//
//  SignUpViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class SignUpViewController: UIViewController {
    
    // MARK: - ViewProperties
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
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
        textField.placeholder = "비밀번호"
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
    
    private let checkPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 확인"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let checkPasswordValidLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemRed
        label.text = " 비밀번호가 다릅니다"
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private let loginTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.darkTintColor, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    private let userInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.lightTintColor, for: .normal)
        button.contentHorizontalAlignment = .center
        button.isEnabled = false
        
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: - Properties
    private let viewModel = SignUpViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfLoginTextFieldStackView()
        setConstraintsOfButtonStackView()
        
        bindingViewModel()
        bindingViewProperties()
    }
    
    // MARK: - Method
    private func pushSignUpUserInfoViewController() {
        let userInfoVC = SignUpUserInformationViewController()
        navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    // MARK: - Biding
    private func bindingViewModel() {
        viewModel.isValidSignUp()
            .sink { [weak self] isValid in
                self?.userInfoButton.isEnabled = isValid
                self?.userInfoButton.setTitleColor(isValid ? .darkTintColor : .lightTintColor, for: .normal)
            }.store(in: &subscriptions)
        
        viewModel.emailValidSubject
            .sink { [weak self] isValid in
                self?.emailValidLabel.text = isValid ? " " : " 이메일이 올바른 형식이 아닙니다"
            }.store(in: &subscriptions)
        
        viewModel.passwordValidSubject
            .sink { [weak self] isValid in
                self?.passwordValidLabel.text = isValid ? " " : " 비밀번호가 올바른 형식이 아닙니다"
            }.store(in: &subscriptions)
        
        viewModel.checkPasswordValidSubject
            .sink { [weak self] isValid in
                self?.checkPasswordValidLabel.text = isValid ? " " : " 비밀번호가 다릅니다"
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
        
        checkPasswordTextField.textPublisher
            .sink { [weak self] text in
                guard let text = text else {
                    return
                }
                self?.viewModel.checkPassword = text
            }.store(in: &subscriptions)
        
        dismissButton.tapPublisher
            .sink { [weak self] in
                self?.dismiss(animated: true)
            }.store(in: &subscriptions)
        
        userInfoButton.tapPublisher
            .sink { [weak self] in
                self?.pushSignUpUserInfoViewController()
            }.store(in: &subscriptions)
    }
    
    // MARK: - UI
    private func configureSubViews() {
        [loginTextFieldStackView, buttonStackView].forEach {
            view.addSubview($0)
        }
        
        [emailTextField, emailValidLabel,
         passwordTextField, passwordValidLabel,
         checkPasswordTextField, checkPasswordValidLabel].forEach {
            loginTextFieldStackView.addArrangedSubview($0)
        }
        
        [dismissButton, userInfoButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraintsOfLoginTextFieldStackView() {
        loginTextFieldStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    private func setConstraintsOfButtonStackView() {
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.top.equalTo(loginTextFieldStackView.snp.bottom).offset(10)
        }
    }
}
