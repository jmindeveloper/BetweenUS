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
    var searchWorkSpaces = [WorkSpace]() {
        didSet {
            doneSearchWorkSpaceSubject.send()
        }
    }
    @Published var searchWorkSpace: String = ""
    let doneSearchWorkSpaceSubject = PassthroughSubject<Void, Never>()
    
    init() {
        bindingSearchWorkSpaceText()
        bindingWorkSpaceDb()
    }
    
    // MARK: - binding
    private func bindingSearchWorkSpaceText() {
        $searchWorkSpace
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.searchWorkSpaces = []
                self?.workSpaceDb.searchWorkSpace(searchWorkSpaceName: text)
            }.store(in: &subscriptions)
    }
    
    private func bindingWorkSpaceDb() {
        workSpaceDb.getWorkSpaceSubject
            .sink { [weak self] workSpaces in
                self?.searchWorkSpaces.append(workSpaces)
            }.store(in: &subscriptions)
    }
}
