//
//  HomeViewController.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var noWorkSpaceView: NoWorkSpaceView?
    
    override func loadView() {
        super.loadView()
        if UserInformation.shared.user?.betweenUsWorkSpace == nil {
            view = NoWorkSpaceView()
            noWorkSpaceView = view as? NoWorkSpaceView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noWorkSpaceView?.setButtonsRound()
    }
}

