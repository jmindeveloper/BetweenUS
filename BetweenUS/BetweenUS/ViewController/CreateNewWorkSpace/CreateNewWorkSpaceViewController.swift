//
//  CreateNewWorkSpaceViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class CreateNewWorkSpaceViewController: UIViewController {
    
    // MARK: - ViewProperties
    private let workSpaceNameTextField: UITextField = {
        let textField = UITextField()
        textField.configure()
        
        return textField
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("사이 만들기", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 24
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        
        return button
    }()
    
    // MARK: - Properties
    private let viewModel = CreateNewWorkSpaceViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfCreateButton()
        setConstraintsOfWorkSpaceNameTextField()
        
        bindingViewProperties()
        bindingViewModel()
    }
    
    // MARK: - binding
    private func bindingViewProperties() {
        workSpaceNameTextField.textPublisher
            .sink { [weak self] text in
                guard let self = self,
                      let text = text else { return }
                self.viewModel.workSpaceName = text
            }.store(in: &subscriptions)
        
        createButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.uploadNewWorkSpace()
            }.store(in: &subscriptions)
    }
    
    private func bindingViewModel() {
        viewModel.uploadWorkSpaceDoneSubject
            .sink { [weak self] in
                self?.dismiss(animated: true)
            }.store(in: &subscriptions)
    }
    
    // MARK: - UI
    private func configureSubViews() {
        [workSpaceNameTextField, createButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraintsOfWorkSpaceNameTextField() {
        workSpaceNameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    private func setConstraintsOfCreateButton() {
        createButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(workSpaceNameTextField.snp.bottom).offset(30)
            $0.height.equalTo(48)
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
}