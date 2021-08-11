//
//  UserListTableViewCell.swift
//  userDetails
//
//  Created by lilac infotech on 09/08/21.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    @IBOutlet weak var imageOut: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
 
    
}
extension UIImageView {
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
 }
