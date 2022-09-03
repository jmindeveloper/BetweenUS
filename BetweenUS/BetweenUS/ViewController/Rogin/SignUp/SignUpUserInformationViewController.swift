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
        textField.inputView = createDateSelectKeyboard()
        textField.inputAccessoryView = createDateSelectToolbar()
        
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
    
    private let userInfoButton: UIButton = {
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
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfTextFieldStackView()
        setConstraintsOfButtonStackView()
    }
    
    // MARK: - Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func createDateSelectKeyboard() -> UIView {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        picker.locale = Locale(identifier: "Korean")
        picker.datePublisher
            .sink { [weak self] date in
                print(date)
            }.store(in: &subscriptions)
        return picker
    }
    
    private func createDateSelectToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
                toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        doneButton.tapPublisher
            .sink { [weak self] in
                print("done")
            }.store(in: &subscriptions)
        toolBar.setItems([doneButton], animated: true) // 툴바에 done버튼 추가
        return toolBar
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
        
        [dismissButton, userInfoButton].forEach {
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
