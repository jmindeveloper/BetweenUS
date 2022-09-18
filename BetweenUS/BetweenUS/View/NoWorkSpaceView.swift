//
//  NoWorkSpaceView.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class NoWorkSpaceView: UIView {
    
    // MARK: - Properties
    let noWorkSpaceLabel: UILabel = {
        let label = UILabel()
        label.text = "연결된 사이가 없습니다."
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        
        return label
    }()
    
    let createNewWorkSpaceButton: UIButton = {
        let button = UIButton()
        button.setTitle("새로운 사이 만들기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.backgroundColor = .orange
        
        return button
    }()
    
    let searchWorkSpacebutton: UIButton = {
        let button = UIButton()
        button.setTitle("사이 검색하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        button.backgroundColor = .systemPink
        
        return button
    }()
    
    private let noWorkSpaceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    // MARK: - Properties
    let pushViewControllerHandler = PassthroughSubject<UIViewController, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfNoWorkSpaceStackView()
        
        bindingViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    func setButtonsRound() {
        createNewWorkSpaceButton.layer.cornerRadius = createNewWorkSpaceButton.frame.height / 2
        searchWorkSpacebutton.layer.cornerRadius = searchWorkSpacebutton.frame.height / 2
    }
    
    // MARK: - Binding
    private func bindingViewProperties() {
        createNewWorkSpaceButton.tapPublisher
            .sink { [weak self] in
                let createNewWorkSpaceVC = CreateNewWorkSpaceViewController()
                self?.pushViewControllerHandler.send(createNewWorkSpaceVC)
            }.store(in: &subscriptions)
        
        searchWorkSpacebutton.tapPublisher
            .sink { [weak self] in
                let searchWorkSpaceVC = SearchWorkSpaceViewController()
                self?.pushViewControllerHandler.send(searchWorkSpaceVC)
            }.store(in: &subscriptions)
    }
    
    // MARK: - UI
    private func configureSubViews() {
        [noWorkSpaceStackView].forEach {
            addSubview($0)
        }
        
        [noWorkSpaceLabel, StackViewSpacer().height(height: 30),
         createNewWorkSpaceButton, searchWorkSpacebutton].forEach {
            noWorkSpaceStackView.addArrangedSubview($0)
        }
    }
    
    private func setConstraintsOfNoWorkSpaceStackView() {
        noWorkSpaceStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
}
