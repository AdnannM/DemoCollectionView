//
//  Nike.swift
//  DemoCollectionView
//
//  Created by Adnann Muratovic on 20.08.21.
//

import Foundation


struct Nike: Hashable {
    var name: String = ""
    var imageName: String = ""
    var description: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, imageName: String, description: String, price: Double, isFeatured:Bool) {
        self.name = name
        self.imageName = imageName
        self.description = description
        self.price = price
        self.isFeatured = isFeatured
    }
    
    
}
