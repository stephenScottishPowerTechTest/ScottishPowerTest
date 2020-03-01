//
//  DynamicSizingFlowLayout.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen Biggerstaff. All rights reserved.
//

import UIKit

final class DynamicSizingFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
        
        layoutAttributesObjects?.forEach({ layoutAttributes in
            
            if layoutAttributes.representedElementCategory == .cell {
                
                if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                    
                    layoutAttributes.frame = newFrame
                }
            }
        })
        
        return layoutAttributesObjects
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let collectionView = collectionView,
            let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        else { return nil }

        layoutAttributes.frame.origin.x = sectionInset.left
        layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
        return layoutAttributes
    }

}
