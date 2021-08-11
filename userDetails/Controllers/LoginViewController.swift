//
//  LoginViewController.swift
//  userDetails
//
//  Created by lilac infotech on 09/08/21.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!

    let userName = "test@opentrends.net"
    let password = "Opentrend1"
    
    private let userManger:UserManger = UserManger()
    var userResponce : [LocalUserResponce]? = []
    
    
    private  var httpUtillity : HttpUtility?
    override func viewDidLoad() {
        super.viewDidLoad()
        httpUtillity = HttpUtility()
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0],"-------the Url")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkHandler.checkInternetConnected(viewController: self)
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        validateUser(un: userNameTxt.text ?? "", pw: passwordTxt.text ?? "")
    }
    
    @IBAction func registerButton(_ sender: Any) {
        registerUser(un: userNameTxt.text ?? "", pw: passwordTxt.text ?? "")
    }
 
    //Register
    func registerUser(un:String,pw:String){
        if un.count != 0 && pw.count != 0{
            httpUtillity?.registerUser(completionHandler: { (respoce) in
                //Responce
                print(respoce)
                DispatchQueue.main.async() {
                    AlertHandler.showAlertDissmissAction("Alert", "Login sucess", target: self) {
                        let push = self.storyboard?.instantiateViewController(identifier: "ListUsersViewController") as! ListUsersViewController
                        self.navigationController?.pushViewController(push, animated: true)
                    }
                }
            })
        }else{
            AlertHandler.showAlert(title: "Alert!", message: "Please fill all the fields", color: .black, target: self)
        }
       
    }
    
    
    //Login
    func validateUser(un:String,pw:String){
        if un == userName && pw == password{
            let push = self.storyboard?.instantiateViewController(identifier: "ListUsersViewController") as! ListUsersViewController
            self.navigationController?.pushViewController(push, animated: true)
        }else{
            AlertHandler.showAlert(title: "Alert!", message: "Enter Credentials are wrong", color: .black, target: self)
        }
    }

    @IBAction func showOfflineData(_ sender: Any) {
        userResponce = userManger.fetchuser()
        if userResponce?.count == 0{
            AlertHandler.showAlert(title: "Alert", message: "There is no data", color: .black, target: self)
        }else{
            let push = self.storyboard?.instantiateViewController(identifier: "ListUsersViewController") as! ListUsersViewController
            push.showOfflineData = true
            self.navigationController?.pushViewController(push, animated: true)
        }
    
    }
}
