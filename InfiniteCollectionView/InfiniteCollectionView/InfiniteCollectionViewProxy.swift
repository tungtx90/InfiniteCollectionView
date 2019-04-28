//
//  InfiniteCollectionViewProxy.swift
//  InfiniteCollectionView
//
//  Created by Tung Tran on 4/27/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation
import UIKit

class InfiniteCollectionViewProxy<ProviderType: NSObjectProtocol>: NSObject {
    weak private(set) var forwardingObject: ProviderType?
    weak private(set) var infiniteCollectionView: ProviderType?
    
    init(forwardingObject: ProviderType?, infiniteCollectionView: ProviderType?) {
        self.forwardingObject = forwardingObject
        self.infiniteCollectionView = infiniteCollectionView
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if infiniteCollectionView?.responds(to: aSelector) == true {
            return infiniteCollectionView
        }
        
        if forwardingObject?.responds(to: aSelector) == true {
            return forwardingObject
        }
        
        return super.forwardingTarget(for: aSelector)
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        return super.responds(to: aSelector) ||
            infiniteCollectionView?.responds(to: aSelector) == true ||
            forwardingObject?.responds(to: aSelector) == true
    }
}

final class InfiniteDataSourceProxy: InfiniteCollectionViewProxy<UICollectionViewDataSource>, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return infiniteCollectionView?.numberOfSections?(in: collectionView) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infiniteCollectionView?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return forwardingObject?.collectionView(collectionView, cellForItemAt: indexPath) ??
            infiniteCollectionView?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
}

final class InfiniteDelegateProxy: InfiniteCollectionViewProxy<UICollectionViewDelegate>, UICollectionViewDelegate {}
