//
//  ViewRouter.swift
//  NewTwitter
//
//  Created by DavidTran on 12/31/17.
//  Copyright © 2017 DavidTran. All rights reserved.
//

import UIKit

protocol ViewRouter {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
}

extension ViewRouter {
   // func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{return false}
}

