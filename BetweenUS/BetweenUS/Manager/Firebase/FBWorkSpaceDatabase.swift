//
//  FBWorkSpaceDatabase.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/12.
//

import Foundation
import FirebaseDatabase

final class FBWorkSpaceDatabase {
    private let ref = Database.database().reference()
    
    func saveNewWorkSpace(workSpace: WorkSpace, createUserId: String, completion: @escaping (() -> Void)) {
        ref.child("workSpace").child(workSpace.id).setValue(
            [
                "id": workSpace.id,
                "name": workSpace.name,
                "users": workSpace.userIds,
                "admin": createUserId,
                "passworld": workSpace.passworld as Any
            ]
        ) { error, _ in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            completion()
        }
    }
}
