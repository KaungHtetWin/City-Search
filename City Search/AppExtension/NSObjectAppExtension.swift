//
//  NSObjectAppExtension.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        UINib(nibName: className, bundle: nil)
    }
}
