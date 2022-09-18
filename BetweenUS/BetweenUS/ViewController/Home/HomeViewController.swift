//
//  HomeViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit
import Combine
import CombineCocoa

final class HomeViewController: UIViewController {
    
    private var noWorkSpaceView: NoWorkSpaceView?
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
//        if UserInformation.shared.user?.betweenUsWorkSpace == nil {
            view = NoWorkSpaceView()
            noWorkSpaceView = view as? NoWorkSpaceView
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingNoWorkSpaceView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noWorkSpaceView?.setButtonsRound()
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - binding
    private func bindingNoWorkSpaceView() {
        noWorkSpaceView?.pushViewControllerHandler
            .sink { [weak self] vc in
                self?.present(vc, animated: true)
            }.store(in: &subscriptions)
    }
}

