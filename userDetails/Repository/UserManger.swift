//
//  UserManger.swift
//  userDetails
//
//  Created by lilac infotech on 10/08/21.
//

import Foundation

struct UserManger {
    private let userDataRepository = UserDataRepository()
    
    func createUser(user:LocalUserResponce){
        userDataRepository.create(userData: user)
    }
    
    func fetchuser() -> [LocalUserResponce]?{
        return userDataRepository.getAll()
    }
}
