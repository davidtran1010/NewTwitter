//
//  PhotoCollectionViewCell.swift
//  NewTwitter
//
//  Created by DavidTran on 1/12/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import SDWebImage
class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    
    func configure(photoURL:String){
        photoView.sd_setImage(with: URL(string: photoURL)) { (image, error, cache, url) in
            if image != nil{
                print("tweet photo loaded with url:\(url)")
            }
            else{
                print("error load image: \(error)")
            }
        }
    }
}
