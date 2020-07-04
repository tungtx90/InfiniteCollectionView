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
    
    init(forwardingObject: ProviderType?) {
        super.init()
        self.forwardingObject = forwardingObject
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if forwardingObject?.responds(to: aSelector) == true {
            return forwardingObject
        }
        
        return super.forwardingTarget(for: aSelector)
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        return super.responds(to: aSelector) ||
            forwardingObject?.responds(to: aSelector) == true
    }
}
