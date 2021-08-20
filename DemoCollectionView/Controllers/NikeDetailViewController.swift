//
//  ViewController.swift
//  DemoCollectionView
//
//  Created by Adnann Muratovic on 20.08.21.
//

import UIKit

class NikeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var nike: Nike?
    
    @IBOutlet weak var shoseImageView: UIImageView! {
        didSet {
            shoseImageView.image = UIImage(named: nike?.imageName ?? "")
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = nike!.name
            nameLabel.font = UIFont(name: "Avenir next", size: 30)
            
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = nike?.description
            descriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.text = "$\(nike!.price)"
            priceLabel.font = UIFont.systemFont(ofSize: 60)
        }
    }
    
    @IBOutlet weak var buyLabel: UIButton! {
        didSet {
            buyLabel.layer.cornerRadius = 20
        }
    }
    
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

