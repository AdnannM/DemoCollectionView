//
//  NikeCollectionViewController.swift
//  DemoCollectionView
//
//  Created by Adnann Muratovic on 20.08.21.
//

import UIKit
import ViewAnimator

private let reuseIdentifier = "Cell"

class NikeCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    private var shareEnable: Bool = false
    private var selectedIcons: [(nike: Nike, snapshot: UIImage)] = []
    
    private var nikeSet: [Nike] = [
        Nike(name: "Nike Adapt", imageName: "nike1", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike2", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike7", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike4", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike5", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike6", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike3", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike8", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike9", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike10", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        Nike(name: "Nike Adapt", imageName: "nike11", description: "A breakthrough lacing system that electronically adjusts to the shape of your foot.", price: 350.00, isFeatured: false),
        
    ]

    lazy var dataSource = configureDataSource()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customLayout()
        collectionView.dataSource = dataSource
        updateSnapshot()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateCell()
    }
    
    // MARK: - Animation
    private func animateCell() {
        let animations = AnimationType.random()
        UIView.animate(views: collectionView.visibleCells, animations: [animations])
    }
    
    // Cell layout
    private func customLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 190, height: 250)
            layout.estimatedItemSize = .zero
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
            layout.scrollDirection = .vertical
        }
    }
    
    // Configure Cell
    enum Section {
        case all
    }
    
    // MARK: - CollectionView DataSource
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Nike> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Nike>(collectionView: collectionView) {
            (collectionView, indexPath, nike) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NikeCollectionViewCell
            
            cell.nikeImageView.image = UIImage(named: nike.imageName)
            cell.nikePriceLabel.text = "$\(nike.price)"
            
            cell.layer.borderWidth = 1.6
            cell.layer.borderColor = UIColor.systemFill.cgColor
            cell.backgroundView = UIImageView(image: UIImage(named: "nike1"))
            
            let selectedBackgound = UIView()
            selectedBackgound.layer.borderColor = UIColor.red.cgColor
            selectedBackgound.layer.borderWidth = 3.0
            cell.selectedBackgroundView = selectedBackgound
            
            
            return cell
            
        }
        
        return dataSource
    }
    
    // MARK: - CollectionView Snapshot
    private func updateSnapshot(animatingChange: Bool = false) {
        // Create snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Nike>()
        snapshot.appendSections([.all])
        snapshot.appendItems(nikeSet, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Action
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        guard shareEnable else {
            // Check shareEnable to Yes and change the button text to Done
            shareEnable = true
            collectionView.allowsMultipleSelection = true
            shareButton.title = "Done"
            shareButton.style = UIBarButtonItem.Style.plain
            
            return
        }
        
        // Make sure the user has selected al least one item
        guard selectedIcons.count >= 0 else {
            return
        }
        
        // Get the snapshots of the selected icon
        let snapshot = selectedIcons.map { $0.snapshot }
        
        // Create an activity view controller for sharing
        let activityController = UIActivityViewController(activityItems: snapshot, applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (activityType, completed, returmedItem, error) in
            // Deselect all selected items
            if let indexPath = self.collectionView?.indexPathsForSelectedItems {
                for indexPath in indexPath {
                    self.collectionView?.deselectItem(at: indexPath, animated: false)
                }
            }
            
            // Remove all items from selectedIcons array
            self.selectedIcons.removeAll(keepingCapacity: true)
            
            // Change the sharing mode on NO
            self.shareEnable = false
            self.collectionView.allowsMultipleSelection = false
            self.shareButton.title = "Share"
            self.shareButton.style = UIBarButtonItem.Style.plain
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNikeDetail" {
            if let indexPath = collectionView?.indexPathsForSelectedItems {
                let destinationVC = segue.destination as! NikeDetailViewController
                destinationVC.nike = nikeSet[indexPath[0].row]
                collectionView?.deselectItem(at: indexPath[0], animated: false)
            }
        }
    }
    
    // MARK: - Control the segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showNikeDetail" {
            if shareEnable {
                return false
            }
        }
        
        return true
    }
}

extension NikeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Check if the sharing mode is enable, otherwise just leave this mode
        guard shareEnable else {
            return
        }
        
        // Determine the selected items by using the indexPaht and take snapshot
        
        if let selectedIcon = dataSource.itemIdentifier(for: indexPath) {
            if let snapshot = collectionView.cellForItem(at: indexPath)?.snapshot {
                // Add the selected item into array
                selectedIcons.append((nike: selectedIcon, snapshot: snapshot))
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Check if the sharing mode is enable, otherwise just leave this mode
        guard shareEnable else {
            return
        }
        
        if let deSelectedImage = dataSource.itemIdentifier(for: indexPath) {
            // Find the index of the deselected icon
            // Here we use the index method and pass it a closure
            // In the closure we compere the name of a deselected icon with all items selected items array
            // if we find the mathc, the index method will return us the index for removal
            if let index = selectedIcons.firstIndex(where: { $0.nike.name == deSelectedImage.name }) {
                selectedIcons.remove(at: index)
            }
        }
    }
}
