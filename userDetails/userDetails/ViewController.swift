//
//  ViewController.swift
//  userDetails
//
//  Created by lilac infotech on 11/08/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//         createEmployee()
        fetchEmployee()
    }
    func createEmployee()
    {
        let employee = UserDetailsList(context: PersistentStorage.shared.context)
        employee.firstname = "ar"
        employee.lastname = "balan"
        employee.email = "ds"
        employee.id = 1
        employee.avthar = "sdadasdasd"
        PersistentStorage.shared.saveContext()
    }

    func fetchEmployee()
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0])
        
        do {
            guard let result = try PersistentStorage.shared.context.fetch(UserDetailsList.fetchRequest()) as? [UserDetailsList] else {return}

            result.forEach({debugPrint($0.firstname)})
        } catch let error
        {
            debugPrint(error)
        }

    }

}

