//
//  UserDataRepository.swift
//  userDetails
//
//  Created by lilac infotech on 10/08/21.
//

import Foundation
import CoreData
//
protocol UserRepository {
    func create(userData:LocalUserResponce)
    func getAll() -> [LocalUserResponce]?
}


struct UserDataRepository:UserRepository {
    
    func create(userData: LocalUserResponce) {
        let userDetails = UserDetailsList(context: PersistentStorage.shared.context)
        userDetails.firstname = userData.firstName
        userDetails.lastname = userData.lastName
        userDetails.email = userData.email
        userDetails.id = Int16(userData.id ?? 0)
        userDetails.avthar = userData.avatar
//        userDetails.profilePic = userData.avatar
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [LocalUserResponce]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: UserDetailsList.self)
        var users :[LocalUserResponce] = []
        
        result?.forEach({ (userD) in
            users.append(userD.convertToUser())
        })
        return users
    }
   static func checkUserId(with id : Int)-> Bool {
        do {
            let context = PersistentStorage.shared.context
            let request : NSFetchRequest<UserDetailsList> = UserDetailsList.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            let numberOfRecords = try context.count(for: request)
            if numberOfRecords == 0 {
                return true
            }else{
               return false
            }
        } catch {
            print("Error saving context \(error)")
        }
        return false
    }
}
