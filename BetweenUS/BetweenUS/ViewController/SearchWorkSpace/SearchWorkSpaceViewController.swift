//
//  SearchWorkSpaceViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/12.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

final class SearchWorkSpaceViewController: UIViewController {
    
    // MARK: - ViewProperties
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationBarItem = UINavigationItem()
        navigationBarItem.titleView = searchBar
        navigationBar.setItems([navigationBarItem], animated: true)
          
        return navigationBar
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.leftView = nil
        searchBar.placeholder = "Search for workspace name or id..."
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        searchBar.returnKeyType = .default
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.textColor = .black
        
        return searchBar
    }()
    
    private lazy var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .viewBackground
        
        return collectionView
    }()
    
    // MARK: - Properteis
    private let viewModel = SearchWorkSpaceViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsNavigationBar()
        setConstraintsOfSearchResultCollectionView()
    }
    
    private func configureSubViews() {
        [navigationBar, searchResultCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraintsNavigationBar() {
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setConstraintsOfSearchResultCollectionView() {
        searchResultCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(7)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
