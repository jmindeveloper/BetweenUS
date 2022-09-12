//
//  CreateNewWorkSpaceViewModel.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/12.
//

import Foundation
import Combine

final class CreateNewWorkSpaceViewModel {
    
    // MARK: - Properties
    private let workSpaceDb = FBWorkSpaceDatabase()
    private let userDb = FBUserDatabase()
    let uploadWorkSpaceDoneSubject = PassthroughSubject<Void, Never>()
    var workSpaceName: String = ""
    
    init() {
        
    }
    
    private func createNewWorkSpace() -> (WorkSpace, String)? {
        guard let id = UserInformation.shared.user?.id else { return nil }
        let workSpace = WorkSpace(
            id: UUID().uuidString,
            name: workSpaceName,
            userIds: [id]
        )
        
        return (workSpace, id)
    }
    
    func uploadNewWorkSpace() {
        guard let workSpace = createNewWorkSpace() else {
            return
        }
        
        workSpaceDb.saveNewWorkSpace(workSpace: workSpace.0, createUserId: workSpace.1) { [weak self] in
            self?.uploadWorkSpaceDoneSubject.send()
        }
        userDb.updateWorkSpace(workSpaceId: workSpace.0.id)
    }
}
