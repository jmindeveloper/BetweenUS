//
//  FBUserDatabase.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/03.
//

import Foundation
import FirebaseDatabase

final class FBUserDatabase {
    let ref = Database.database().reference()
    
    func saveNewUser(user: User) {
        ref.child("users").child(user.id).setValue(
            [
                "id": user.id,
                "email": user.email,
                "name": user.name,
                "nickName": user.nickName,
                "birthday": user.birthday
            ]
        )
        
        ref.child("users").child("nickName").child(user.nickName).child("id").observeSingleEvent(of: .value) { [weak self] snapshot in
            var snapshot = snapshot.value as? [String] ?? []
            snapshot.append(user.id)
            self?.ref.child("users").child("nickName").child(user.nickName).setValue(["id": snapshot])
        }
    }
    
    func loadUser(id: String, completion: @escaping (User) -> Void) {
        ref.child("users").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let snapshotData = snapshot.value as? [String: Any] else { return }
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshotData, options: [])
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                completion(user)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateWorkSpace(workSpaceId: String) {
        guard let user = UserInformation.shared.user else {
            return
        }
        var workSpace = user.betweenUsWorkSpace
        if workSpace != nil {
            workSpace?.append(workSpaceId)
        } else {
            workSpace = [workSpaceId]
        }
        
        UserInformation.shared.user = user
        
        ref.child("users").child(user.id).child("betweenUsWorkSpace").setValue(workSpace)
    }
}
