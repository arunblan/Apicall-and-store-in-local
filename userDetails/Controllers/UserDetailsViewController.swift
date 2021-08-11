//
//  UserDetailsViewController.swift
//  userDetails
//
//  Created by lilac infotech on 09/08/21.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var imageViewOut: UIImageView!
    
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    
    var defalultImage = "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg"
    var userData:Datum?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstnameLbl.text = userData?.firstName
        lastNameLbl.text = userData?.lastName
        emailLbl.text = userData?.email
        ImageHandler.imageHandler(url: defalultImage, imageView: imageViewOut)
    }

    
}
