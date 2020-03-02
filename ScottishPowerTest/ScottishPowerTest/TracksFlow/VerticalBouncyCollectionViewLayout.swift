//
//  VerticalBouncyCollectionViewLayout.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

open class VerticalBouncyCollectionViewLayout: UICollectionViewFlowLayout {
    
    private var damping: CGFloat = 0.6
    private var frequency: CGFloat = 4
    
    public convenience init(damping: CGFloat, frequency: CGFloat) {
        
        self.init()
        self.damping = damping
        self.frequency = frequency
    }
    
    public override init() {
        super.init()
        self.minimumLineSpacing = 16.0
        self.minimumInteritemSpacing = 16.0
        self.estimatedItemSize = CGSize(width: (collectionView?.frame.size.width ?? 312) - 32, height: 120)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        animator.removeAllBehaviors()
    }
    
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    
    open override func prepare() {
        
        super.prepare()
        
        //We want to get elements outwith the bounds of the screen slightly in order to add the UIKitDynamics before they come into view.
        //There's likely a better way of doing this to account for fast scrolling etc.
        guard let view = collectionView,
            let attributes = super.layoutAttributesForElements(in: view.bounds.insetBy(dx: -200, dy: -200))?.compactMap({ $0.copy() as? UICollectionViewLayoutAttributes })
            else { return }
        
        //remove all the behaviours that aren't on the screen and add new ones that are coming in.
        self.removeOldBehaviors(attributes: attributes)
        self.addNewBehaviors(attributes: attributes)
    }
    
    private func removeOldBehaviors(attributes: [UICollectionViewLayoutAttributes]) {
        
        let indexPaths = attributes.map { $0.indexPath }
        
        //if the indexPaths contains this behaviour's indexPath then it's still visible and we don't wanna remove it.
        let behaviors: [UIAttachmentBehavior] = animator.behaviors.compactMap {
            
            guard let behavior = $0 as? UIAttachmentBehavior,
                let itemAttributes = behavior.items.first as? UICollectionViewLayoutAttributes else { return nil }
            
            
            return indexPaths.contains(itemAttributes.indexPath) ? nil : behavior
        }
        
        behaviors.forEach { animator.removeBehavior($0) }
    }
    
    private func addNewBehaviors(attributes: [UICollectionViewLayoutAttributes]) {
        
        //By the time this is called we've removed the offscreen behaviours.
        //Now we just have to add the ones coming into the screen.
        let indexPaths = animator.behaviors.compactMap { (($0 as? UIAttachmentBehavior)?.items.first as? UICollectionViewLayoutAttributes)?.indexPath }
        
        //we only want behaviours that aren't already in the animator
        let behaviors: [UIAttachmentBehavior] = attributes.compactMap {
            
            if indexPaths.contains($0.indexPath) {
                
                return nil
                
            } else {
                
                return UIAttachmentBehavior(item: $0, attachedToAnchor: CGPoint(x: floor($0.center.x), y: floor($0.center.y)))
            }
        }
        
        behaviors.forEach {
            
            $0.damping = damping
            $0.frequency = frequency
            $0.length = 0.5
            $0.frictionTorque = 6.0
            animator.addBehavior($0)
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return animator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return animator.layoutAttributesForCell(at: indexPath)
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        guard let collectionView = collectionView else { return false }
        
        animator.behaviors.forEach {
            
            guard let behavior = $0 as? UIAttachmentBehavior,
                let item = behavior.items.first else { return }
            
            let delta = CGVector(dx: newBounds.origin.x - collectionView.bounds.origin.x,
                                 dy: newBounds.origin.y - collectionView.bounds.origin.y)
            
            let xDistanceFromTouch = abs(collectionView.panGestureRecognizer.location(in: collectionView).x - behavior.anchorPoint.x)
            let yDistanceFromTouch = abs(collectionView.panGestureRecognizer.location(in: collectionView).y - behavior.anchorPoint.y)
            
            let resistance = CGVector(dx:  xDistanceFromTouch / 750,
                                      dy:  yDistanceFromTouch / 750)
            
            // clamp the product of the delta and scroll resistance by the delta.
            //If this wasn't clamped we could start moving in the wrong direction.
            item.center.y += delta.dy < 0 ? max(delta.dy, delta.dy * resistance.dy) : min(delta.dy, delta.dy * resistance.dy)
            item.center = CGPoint(x: floor(item.center.x), y: floor(item.center.y))
            
            animator.updateItem(usingCurrentState: item)
        }
        
        return collectionView.bounds.width != newBounds.width
    }
}
