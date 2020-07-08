//
//  InfinityCollectionView.swift
//  InfiniteCollectionView
//
//  Created by Tung Tran on 4/27/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

class InfiniteCollectionView: UICollectionView {
    private var dataSourceProxy: InfiniteDataSourceProxy?
    private var delegateProxy: InfiniteDelegateProxy?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Override
    override weak var dataSource: UICollectionViewDataSource? {
        set {
            if let value = newValue {
                dataSourceProxy = InfiniteDataSourceProxy(forwardingObject: value)
                super.dataSource = dataSourceProxy
            } else {
                super.dataSource = nil
            }
        }
        
        get {
            return super.dataSource
        }
    }
    
    override weak var delegate: UICollectionViewDelegate? {
        set {
            if let value = newValue {
                delegateProxy = InfiniteDelegateProxy(forwardingObject: value)
                super.delegate = delegateProxy
            } else {
                super.delegate = nil
            }
        }
        
        get {
            return super.delegate
        }
    }
}

// MARK: - Internal
extension InfiniteCollectionView {
    func scrollToCenter() {
        guard dataSourceProxy?.numberOfSections(in: self) ?? 0 > 0,
              dataSourceProxy?.collectionView(self, numberOfItemsInSection: 1) ?? 0 > 0
        else { return }
        scrollToItem(at: IndexPath(item: 0, section: 1), at: .centeredHorizontally, animated: false)
    }
    
    func getIndexPath(from indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: indexPath.item, section: getSectionIndex(from: indexPath.section))
    }
    
    func getSectionIndex(from sectionIndex: Int) -> Int {
        let numberOfSections = dataSourceProxy?.numberOfSections(in: self) ?? 1
        return  sectionIndex % numberOfSections
    }
}

// MARK: - Private
extension InfiniteCollectionView {
    private func setup() {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
}
