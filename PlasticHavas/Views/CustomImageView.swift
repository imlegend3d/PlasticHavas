//
//  CustomImageView.swift
//  NewFaceTV
//
//  Created by David on 2019-20-20.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    private var task: URLSessionDataTask!
    private var imageURLString: String?
    
    func loadImage(from url: URL){
        
        imageURLString = url.absoluteString
        //clears the image
        image = nil
        
        //checks that the task does not exist, cancels it, so that the right image is not requested.
        if let task = task {
            task.cancel()
        }
        //checking if already cached images for the url exist in cache and if so loading them to the imageview.image
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        //Getting image info from url
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("Couldn't load image from url: \(url)")
                return
            }
            
            DispatchQueue.main.async {
                //adding the image to cache
                imageCache.setObject(newImage, forKey: (url.absoluteString as AnyObject))
                
                //Check that right image is in the right place
                if self.imageURLString == url.absoluteString {
                    self.image = newImage
                }
            }
        }
        task.resume()
    }

}
