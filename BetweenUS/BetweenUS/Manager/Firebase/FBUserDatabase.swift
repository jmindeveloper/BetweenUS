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
    
    func saveNewUser(user: User, id: String) {
        ref.child("users").child(id).setValue(
            [
                "name": user.name,
                "nickName": user.nickName,
                "birthday": user.birthday,
                "connect": nil
            ]
        )
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
}
