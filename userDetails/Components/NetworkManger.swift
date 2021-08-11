//
//  NetworkManger.swift
//  userDetails
//
//  Created by lilac infotech on 10/08/21.
//

import Foundation
import Alamofire
//MARK:- Internet Manger

class NetworkHandler{
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
static func checkInternetConnected(viewController:UIViewController) ->Bool{
    if isConnectedToInternet(){
     print("is connected")
        return true
    }else{
        return false
        AlertHandler.showAlert(title: "Network not reachable !", message: "Whould you see the local data", color: .black, target: viewController)
    }
}
}

