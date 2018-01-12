//
//  CollectionViewController.swift
//  NewTwitter
//
//  Created by DavidTran on 1/13/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController:NSObject, UICollectionViewDataSource,UICollectionViewDelegate{
    var tableViewCellIndexPath:IndexPath?
    var photoURLStringArray:[String]?
    var rootView:UIView?

    init(rootView:UIView,tableViewCellIndexPath: IndexPath,photoURLStringArray:[String]) {
        self.tableViewCellIndexPath = tableViewCellIndexPath
        self.photoURLStringArray = photoURLStringArray
        self.rootView = rootView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLStringArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        print("collection cell:\(indexPath.item)")
        
        // change cell size depend on photos count
        if photoURLStringArray!.count > 0{
            cell.configure(photoURL: photoURLStringArray![indexPath.item])
            let layout = UICollectionViewFlowLayout.init()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            collectionView.collectionViewLayout = layout
            
            if photoURLStringArray!.count == 1 {
                cell.bounds.size.width = rootView!.safeAreaLayoutGuide.layoutFrame.size.width - 20
            }
            else{
                cell.bounds.size.width = rootView!.safeAreaLayoutGuide.layoutFrame.size.width * 2/3
            }
        }
        
        return cell
    }
    
    
    
    
}
