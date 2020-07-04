//
//  InfiniteDelegateProxy.swift
//  InfiniteCollectionView
//
//  Created by Tung Tran on 7/4/20.
//  Copyright © 2020 tungtran. All rights reserved.
//

import Foundation
import UIKit

final class InfiniteDelegateProxy: InfiniteCollectionViewProxy<UICollectionViewDelegate>, UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollToCenter(of: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToCenter(of: scrollView)
    }
}

// MARK: - Private
extension InfiniteDelegateProxy {
    private func scrollToCenter(of scrollView: UIScrollView) {
        guard let collectionViewLayout = (scrollView as? UICollectionView)?.collectionViewLayout else { return }
        
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
