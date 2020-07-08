//
//  ViewController.swift
//  InfiniteCollectionView
//
//  Created by Tung Tran on 4/20/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: InfiniteCollectionView!
    
    private let items = [1,2,3]
    private let colors: [UIColor] = [.red, .green, .blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.isPagingEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.scrollToCenter()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        
        cell.cellLabel.text = "\(items[self.collectionView.getIndexPath(from: indexPath).item])"
        cell.backgroundColor = colors[self.collectionView.getIndexPath(from: indexPath).item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select indexPath = \(indexPath.row)")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
