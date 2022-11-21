//
//  CustomImageView.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import UIKit
let imagesCache = NSCache<NSString, AnyObject>()
class CustomImageView: UIImageView {
  private let network = Network()
  var urlString: String?
  func setImg(from url: String) {
    urlString = url
    if let _image = imagesCache.object(forKey: NSString(string: url)) as? UIImage {
      image = _image
      return
    }
    
    if let value = urlString {
      network.request(value) { (result) in
        DispatchQueue.main.async {
          switch result {
          case let .success(response):
            self.set(imgData: response!, for: value.description)
          case .failure(_):
            break
//            self.image = nil
          }
        }
      }
    }
  }
  
  func set(imgData: UIImage, for url: String) {
    DispatchQueue.main.async {
      self.image = imgData
      imagesCache.setObject(imgData, forKey: NSString(string: url.description))
    }
  }
}
