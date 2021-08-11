//
//  ImageHandler.swift
//  userDetails
//
//  Created by lilac infotech on 10/08/21.
//

import Foundation
import UIKit
import SDWebImage
class ImageHandler{
    static func imageHandler(url:String,imageView:UIImageView){
        let imageUrl = URL(string: url)!
        imageView.sd_setImage(with: imageUrl)
       

    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL,imageView:UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                imageView.image = UIImage(data: data)
            }
        }
    }
    
}

