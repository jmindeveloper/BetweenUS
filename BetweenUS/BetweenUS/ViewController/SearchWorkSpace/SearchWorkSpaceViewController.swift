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
        let layout = UICollectionView.singleTableLayout(widthOffset: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .viewBackground
        collectionView.register(WorkSpaceCollectionViewCell.self, forCellWithReuseIdentifier: WorkSpaceCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properteis
    private let viewModel = SearchWorkSpaceViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewBackground
        configureSubViews()
        setConstraintsNavigationBar()
        setConstraintsOfSearchResultCollectionView()
        
        bindingViewProperties()
        bindingViewModel()
    }
    
    // MARK: - Binding
    private func bindingViewProperties() {
        searchBar.searchTextField.textPublisher
            .sink { [weak self] searchText in
                if searchText != self?.viewModel.searchWorkSpace {
                    self?.viewModel.searchWorkSpace = searchText ?? ""
                }
            }.store(in: &subscriptions)
    }
    
    private func bindingViewModel() {
        viewModel.doneSearchWorkSpaceSubject
            .sink { [weak self] in
                self?.searchResultCollectionView.reloadData()
            }.store(in: &subscriptions)
    }
    
    // MARK: - UI
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

extension SearchWorkSpaceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchWorkSpaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkSpaceCollectionViewCell.identifier, for: indexPath) as? WorkSpaceCollectionViewCell else {
            return UICollectionViewCell()
        }
        let workSpace = viewModel.searchWorkSpaces[indexPath.item]
        cell.configureCell(workSpace: workSpace)
        
        return cell
    }
}

extension SearchWorkSpaceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let workSpace = viewModel.searchWorkSpaces[indexPath.item]
        let alert = UIAlertController
            .createAlert(message: "\(workSpace.name)에 가입하시겠습니까?")
            .addAction(title: "확인") {
                print("가입하기")
            }
            .addAction(title: "취소", style: .cancel)
        
        present(alert, animated: true)
    }
}
