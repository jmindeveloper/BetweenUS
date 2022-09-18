//
//  FBWorkSpaceDatabase.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/12.
//

import Foundation
import Combine
import FirebaseDatabase

final class FBWorkSpaceDatabase {
    private let ref = Database.database().reference()
    let getWorkSpaceSubject = PassthroughSubject<WorkSpace, Never>()
    
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
                print(error!.localizedDescription)
                return
            }
            completion()
        }
    }
    
    func getWorkSpace(getWorkSpaceId: String) {
        ref.child("workSpace").child(getWorkSpaceId).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let snapshotData = snapshot.value as? [String: Any] else {
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshotData, options: [])
                let decoder = JSONDecoder()
                let workSpace = try decoder.decode(WorkSpace.self, from: data)
                self?.getWorkSpaceSubject.send(workSpace)
            } catch let error {
                print(error.localizedDescription )
            }
        }
    }
    
    func searchWorkSpace(searchWorkSpaceName: String) {
        ref.child("workSpace").observeSingleEvent(of: .value) { [weak self] snapshot in
            let values = snapshot.value
            let dic = values as! [String: [String: Any]]
            for index in dic {
                if let workSpaceName = (index.value["name"] as? String) {
                    if workSpaceName.contains(searchWorkSpaceName) {
                        if let id = index.value["id"] as? String {
                            self?.getWorkSpace(getWorkSpaceId: id)
                        }
                    }
                }
                
                if let workSpaceId = (index.value["id"] as? String) {
                    if workSpaceId.contains(searchWorkSpaceName) {
                        self?.getWorkSpace(getWorkSpaceId: workSpaceId)
                    }
                }
            }
        }
    }
}
