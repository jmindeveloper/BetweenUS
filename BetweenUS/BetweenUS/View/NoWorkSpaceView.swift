//
//  NoWorkSpaceView.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit
import SnapKit

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
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsOfNoWorkSpaceStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    func setButtonsRound() {
        createNewWorkSpaceButton.layer.cornerRadius = createNewWorkSpaceButton.frame.height / 2
        searchWorkSpacebutton.layer.cornerRadius = searchWorkSpacebutton.frame.height / 2
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
