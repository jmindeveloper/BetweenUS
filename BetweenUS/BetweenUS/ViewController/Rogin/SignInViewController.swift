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
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
    }
}
