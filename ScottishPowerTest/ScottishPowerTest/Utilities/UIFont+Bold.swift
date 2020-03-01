//
//  UIFont+Bold.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//
import UIKit

extension UIFont {

    func withSymbolicTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        
        guard let descriptorWithTraits = fontDescriptor.withSymbolicTraits(traits) else {

            return self
        }
        
        return UIFont(descriptor: descriptorWithTraits, size: 0)
    }
    
    func bold() -> UIFont {
        
        return withSymbolicTraits(.traitBold)
    }
}
