//
//  TrackDetailsViewModel.swift
//  ScottishPowerTest
//
//  Created by Stephen  on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
/*
 Typically I would not do a view model for something this simple. But I wanted to show the flow of a model from
 List VC -> Coordinator -> Bind function -> View Model
 */
class TrackDetailsViewModel {
    
    var trackDetails: TrackDetails
    
    init(details: TrackDetails) {
        
        self.trackDetails = details
    }
    
    //using double to avoid having to import UIKit just for this CGFloat
    func biggerImageURL(width: Double) -> String {
        
        let dimensionRoundedUp = 100 * Int(ceil(width / 100))

        return trackDetails.artworkUrl100.replacingOccurrences(of: "source/100x100bb.jpg",
                                                 with: "source/\(dimensionRoundedUp)x\(dimensionRoundedUp)bb.jpg")
    }
}
