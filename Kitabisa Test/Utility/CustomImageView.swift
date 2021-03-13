//
//  UIImageViewHelper.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    var imageUrlString: String?

    func downloadImageFrom(withUrl urlString : String) {
        imageUrlString = urlString

        let url = URL(string: urlString)
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: NSString(string: urlString))
                    if self.imageUrlString == urlString {
                        self.image = image
                    }
                }
            }
        }).resume()
    }
}

