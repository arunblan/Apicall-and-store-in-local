//
//  AlertView.swift
//  test
//
//  Created by arunBalan on 11/08/20.
//  Copyright © 2020 arunbalan. All rights reserved.
//

import Foundation
import UIKit

class AlertHandler {
    
    
    static func showAlert( title: String?, message: String?,color :UIColor?, target: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.view.tintColor = .black
        alertController.addAction(okayAction)
        target.present(alertController, animated: true, completion: nil)
    }
    static func showAlertDissmissAction(_ title: String?, _ message: String?, target: UIViewController,actionHandler: ( () -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okayAction = UIAlertAction(title: "Dismiss", style: .cancel) {(action) in
            actionHandler?()
        }
        alertController.view.tintColor = UIColor.black
        alertController.addAction(okayAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
 

}
