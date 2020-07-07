//
//  InfiniteDataSourceProxy.swift
//  InfiniteCollectionView
//
//  Created by Tung Tran on 7/4/20.
//  Copyright © 2020 tungtran. All rights reserved.
//

import Foundation
import UIKit

final class InfiniteDataSourceProxy: InfiniteCollectionViewProxy<UICollectionViewDataSource>, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return forwardingObject?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forwardingObject?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (forwardingObject?.numberOfSections?(in: collectionView) ?? 1) * 3
    }
}
