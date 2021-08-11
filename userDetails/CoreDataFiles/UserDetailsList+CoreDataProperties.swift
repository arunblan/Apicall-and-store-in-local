//
//  UserDetailsList+CoreDataProperties.swift
//  userDetails
//
//  Created by lilac infotech on 11/08/21.
//
//

import Foundation
import CoreData



extension UserDetailsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetailsList> {
        return NSFetchRequest<UserDetailsList>(entityName: "UserDetailsList")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var email: String?
    @NSManaged public var avthar: String?
    @NSManaged public var id: Int16
    
    func convertToUser() -> LocalUserResponce{
        return LocalUserResponce(id: Int(self.id), email: self.email ?? "", firstName: self.firstname ?? "", lastName: self.lastname ?? "", avatar: self.avthar ?? "")
    }

}

extension UserDetailsList : Identifiable {

}
