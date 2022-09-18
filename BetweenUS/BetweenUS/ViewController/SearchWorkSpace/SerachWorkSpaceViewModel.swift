//
//  SerachWorkSpaceViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/18.
//

import Foundation

final class SearchWorkSpaceViewModel {
    
    private let workSpaceDb = FBWorkSpaceDatabase()
    var searchWorkSpace: String = ""
    
    init() {
        workSpaceDb.searchWorkSpace(workSpace: "iOS 연습방")
    }
    
    
}
