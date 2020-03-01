//
//  TrackSummaryCollectionViewCell.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen Biggerstaff. All rights reserved.
//

import UIKit

/*
        There's a couple of decisions been made on this cell.
 
        1.  Album art from iTunes is always square, so I've added a constraint of a square aspect ratio rather than the rectangle from wireframes.
            An alternative to that is to download a resolution matching the width rather than height and crop the artwork into the UIImage.
            I've added a proportional width constraint to half the length of the cell with a 0 priority. In a working environment I'd talk to the
            designer about this and make sure the half width is a higher priority than showing the album artwork in the correct aspect ratio.
            In practical terms here, we could change the aspect ratio constraint to 0 priotity and up the proportional width constraint priority to
            toggle between these decisions.
        1a. I've noticed by playing around with the iTunes API that we can actually request album art in any square size by changing the URL ourselves.
            This means that we could do the steps above quite simply, as we could download say 160x160 artwork and display a cropped 160x120 section of it.
        2.  I've assumed that dynamic type and content scaling is desirable for accessability reasons and also I cannot ask the designer what the
            truncation behaviour should be. To go back to truncating we can simply change the number of lines to the desired max on the labels,
            while also turning on or off dynamic font scaling in the labels.
 */

class TrackSummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        //Color gotten by using a droplet picker on the wireframes border.
        self.contentView.layer.borderColor = UIColor(red:0.88, green:0.89, blue:0.89, alpha:1.00).cgColor
        self.contentView.layer.borderWidth = 1.0
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let localLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        localLayoutAttributes.frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize,
                                                              withHorizontalFittingPriority: .required,
                                                              verticalFittingPriority: .fittingSizeLevel)
        
        return localLayoutAttributes
    }
}
