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
    
    // MARK: - Override
    override weak var dataSource: UICollectionViewDataSource? {
        set {
            dataSourceProxy = InfiniteDataSourceProxy(forwardingObject: newValue, infiniteCollectionView: self)
            super.dataSource = dataSourceProxy
        }
        
        get {
            return super.dataSource
        }
    }
    
    override weak var delegate: UICollectionViewDelegate? {
        set {
            delegateProxy = InfiniteDelegateProxy(forwardingObject: newValue, infiniteCollectionView: self)
            super.delegate = delegateProxy
        }
        
        get {
            return super.delegate
        }
    }
    
    // MARK: - Internal
    func scrollToCenter() {
        guard dataSourceProxy?.numberOfSections(in: self) ?? 0 > 0 else { return }
        scrollToItem(at: IndexPath(item: 0, section: 1), at: .centeredHorizontally, animated: false)
    }
    
    func getIndexPath(from indexPath: IndexPath) -> IndexPath {
        return IndexPath(item: indexPath.item, section: getSectionIndex(from: indexPath.section))
    }
    
    func getSectionIndex(from sectionIndex: Int) -> Int {
        let numberOfSections = dataSourceProxy?.numberOfSections(in: self) ?? 1
        return  sectionIndex % numberOfSections
    }
    
    // MARK: - Private
    private func centerScrollView(_ scrollView: UIScrollView) {
        let pageWidth = Float(collectionViewLayout.collectionViewContentSize.width / 3)
        let xOffset = Float(scrollView.contentOffset.x)
        if xOffset > 2 * pageWidth {
            var offset = scrollView.contentOffset
            offset.x = CGFloat(xOffset - (2 * pageWidth) + pageWidth)
            scrollView.contentOffset = offset
        } else if xOffset < pageWidth {
            var offset = scrollView.contentOffset
            offset.x = CGFloat(xOffset + pageWidth)
            scrollView.contentOffset = offset
        }
    }
}

// MARK: - UIScrollViewDelegate
extension InfiniteCollectionView {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        centerScrollView(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerScrollView(scrollView)
    }
}

// MARK: - UICollectionViewDataSource
extension InfiniteCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSourceProxy?.forwardingObject?.collectionView(self, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceProxy?.forwardingObject?.collectionView(self, numberOfItemsInSection: section) ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (dataSourceProxy?.forwardingObject?.numberOfSections?(in: self) ?? 0) * 3
    }
}

// MARK: - UICollectionViewDelegate
extension InfiniteCollectionView: UICollectionViewDelegate {}
