//
//  UIView+Snapshot.swift
//  DemoCollectionView
//
//  Created by Adnann Muratovic on 20.08.21.
//

import Foundation
import UIKit


// MARK: - Take the snapshot of the view or a collection view cell
extension UIView {
    var snapshot: UIImage? {
        var image: UIImage? = nil
        
        UIGraphicsBeginImageContext(bounds.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
