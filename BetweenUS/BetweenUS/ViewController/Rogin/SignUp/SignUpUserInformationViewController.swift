//
//  SignUpUserInformationViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/02.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class SignUpUserInformationViewController: UIViewController {
    
    // MARK: - ViewProperties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " 이름"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = " 닉네임"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = " 생년월일"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.configure()
        textField.placeholder = "이름"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.configure()
        textField.placeholder = "닉네임"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "생년월일"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.darkTintColor, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    private let SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입", for: .normal)
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
    private let viewModel: SignUpViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfTextFieldStackView()
        setConstraintsOfButtonStackView()
        
        configureView()
        
        bindingViewProperties()
        bindingViewModel()
        
        createDateSelectToolbar()
        createDateSelectKeyboard()
    }
    
    // MARK: - Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func createDateSelectKeyboard() {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        picker.locale = Locale(identifier: "Korean")
        picker.datePublisher
            .sink { [weak self] date in
                self?.selectDate(date: date)
            }.store(in: &subscriptions)
        birthdayTextField.inputView = picker
    }
    
    private func createDateSelectToolbar() {
        let toolBar = UIToolbar()
                toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        doneButton.tapPublisher
            .sink { [weak self] in
                self?.doneSelectDate()
            }.store(in: &subscriptions)
        toolBar.setItems([doneButton], animated: false)
        birthdayTextField.inputAccessoryView = toolBar
    }
    
    private func selectDate(date: Date) {
        birthdayTextField.text = String.dateToString(date: date)
    }
    
    private func doneSelectDate() {
        viewModel.birthDay = birthdayTextField.text ?? String.dateToString()
        birthdayTextField.resignFirstResponder()
    }
    
    func configureView() {
        birthdayTextField.text = viewModel.birthDay
        nameTextField.text = viewModel.name
        nickNameTextField.text = viewModel.nickName
    }
    
    // MARK: - Binding
    private func bindingViewProperties() {
        nameTextField.textPublisher
            .sink { [weak self] name in
                guard let name = name else {
                    return
                }
                self?.viewModel.name = name
            }.store(in: &subscriptions)
        
        nickNameTextField.textPublisher
            .sink { [weak self] nickName in
                guard let nickName = nickName else {
                    return
                }
                self?.viewModel.nickName = nickName
            }.store(in: &subscriptions)
        
        dismissButton.tapPublisher
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }.store(in: &subscriptions)
        
        SignUpButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.signUp()
            }.store(in: &subscriptions)
    }
    
    private func bindingViewModel() {
        viewModel.notEmptyAllTextFieldSubject
            .sink { [weak self] notEmpty in
                self?.SignUpButton.isEnabled = notEmpty
                self?.SignUpButton.setTitleColor(notEmpty ? .darkTintColor : .lightTintColor, for: .normal)
            }.store(in: &subscriptions)
        
        viewModel.authSuccessSubject
            .sink { [weak self] in
                print("회원가입 성공")
            }.store(in: &subscriptions)
        
        viewModel.authFailureSubject
            .sink { [weak self] errorMessage in
                print("회원가입 실패: ", errorMessage)
            }.store(in: &subscriptions)
    }
    
    // MARK: - UI
    private func configureSubViews() {
        [textFieldStackView, buttonStackView].forEach {
            view.addSubview($0)
        }
        
        [nameLabel, nameTextField, nickNameLabel, nickNameTextField,
         birthdayLabel, birthdayTextField].forEach {
            textFieldStackView.addArrangedSubview($0)
        }
        
        [dismissButton, SignUpButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraintsOfTextFieldStackView() {
        textFieldStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    private func setConstraintsOfButtonStackView() {
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(10)
        }
    }
}
