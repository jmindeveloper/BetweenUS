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
    var searchWorkSpaces = [WorkSpace]()
    @Published var searchWorkSpace: String = ""
    
    init() {
//        workSpaceDb.searchWorkSpace(workSpace: "iOS 연습방")
        bindingSearchWorkSpaceText()
        bindingWorkSpaceDb()
    }
    
    // MARK: - binding
    private func bindingSearchWorkSpaceText() {
        $searchWorkSpace
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.workSpaceDb.searchWorkSpace(searchWorkSpaceName: text)
            }.store(in: &subscriptions)
    }
    
    private func bindingWorkSpaceDb() {
        workSpaceDb.getWorkSpaceSubject
            .collect(.byTime(DispatchQueue.main, 1))
            .sink { [weak self] workSpaces in
                self?.searchWorkSpaces = workSpaces
            }.store(in: &subscriptions)
    }
}
