//
//  PhotoCollectionViewCell.swift
//  NewTwitter
//
//  Created by DavidTran on 1/12/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher
class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBOutlet weak var photoView: UIImageView!
    fileprivate func initView(){
        photoView.layer.cornerRadius = 10
        photoView.clipsToBounds = true
        
    }
    func configure(photoURL:String){
        initView()

//        photoView.sd_addActivityIndicator()
//        photoView.sd_showActivityIndicatorView()
//        SDImageCache.shared().diskImageExists(withKey: photoURL) { (isExisted) in
//            if isExisted{
//                self.photoView.image = SDImageCache.shared().imageFromDiskCache(forKey: photoURL)
//                self.photoView.sd_removeActivityIndicator()
//            }
//            else{
//                SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: photoURL), options: SDWebImageDownloaderOptions.continueInBackground, progress: nil, completed: { (image, data, error, isFinished) in
//                    if isFinished{
//                        self.photoView.image = image
//                        self.photoView.sd_removeActivityIndicator()
//                        SDImageCache.shared().storeImageData(toDisk: data, forKey: photoURL)
//                        //                SDImageCache.shared().store(image, forKey: photoURL, completion: {
//                        //                    print("tweet photo saved with key:\(photoURL)")
//                        //                })
//                    }
//                })
//            }
//        }
//
        /////////////////////////////////////
        DispatchQueue.main.async {
            self.Indicator.isHidden = false
            self.photoView.sd_setImage(with: URL(string: photoURL)) { (image, error, cache, url) in
                if image != nil{
                    self.Indicator.isHidden = true
                    //self.photoView.sd_removeActivityIndicator()
                    print("tweet photo loaded with url:\(url)")
                }
                else{
                    print("error load image: \(error)")
                }
            }
        }
        
    }
}
