//
//  ImageHandling.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage



//Reused my Image.swift code from "Newsreader" Repo on my Github
//Initially didn't want to Alamofire or other pod libraries, but
//given the limited still used one.

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(_ urlString: String){
        self.image = nil
        
        //Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        
        AF.request(urlString).responseImage { response in
            switch response.result {
                case .success(let value):
                    let downloadedImage = value
                    
                    if (downloadedImage != nil) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        //Set image to downloaded image
                        self.image = downloadedImage
                    }
                case .failure(let error):
                    // Set placeholder image
                    self.image = UIImage(named: "no-image")
                                
            }

        }
    }
}
