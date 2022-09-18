//
//  SerachWorkSpaceViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/18.
//

import Foundation
import Combine

final class SearchWorkSpaceViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    private let workSpaceDb = FBWorkSpaceDatabase()
    @Published var searchWorkSpace: String = ""
    
    init() {
//        workSpaceDb.searchWorkSpace(workSpace: "iOS 연습방")
        searchWorkSpaceDidChanged()
    }
    
    private func searchWorkSpaceDidChanged() {
        $searchWorkSpace
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.workSpaceDb.searchWorkSpace(workSpaceName: text)
            }.store(in: &subscriptions)
    }
    
}
