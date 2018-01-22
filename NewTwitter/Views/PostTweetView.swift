//
//  PostTweetView.swift
//  NewTwitter
//
//  Created by DavidTran on 1/19/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import UIKit

class PostTweetView: UIView{
    
    var view:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
            xibSetup()
    }
    
}

private extension PostTweetView{
    func xibSetup(){
        view = loadNib()
        view.frame = bounds
        addSubview(view)
    }
    func loadNib()->UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PostTweetView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
