//
//  ImageUtils.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/25/21.
//

import Foundation
import UIKit

class ImageUtils{
    static let shared = ImageUtils()
    
    //Get image according to url
    func getImageFromUrl(urlString : String) -> UIImage{
        if let url = URL(string: urlString){
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                let image = UIImage(data: imageData)
                return image!
            }
        }
        return UIImage()
    }
}
