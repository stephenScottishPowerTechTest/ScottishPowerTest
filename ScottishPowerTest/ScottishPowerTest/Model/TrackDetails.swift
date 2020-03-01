//
//  TrackDetails.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen Biggerstaff. All rights reserved.
//

import Foundation

struct TrackDetails: Codable {
    
    var artistName: String
    var trackName: String
    var trackPrice: Decimal
    var releaseDate: Date
    var artworkUrl100: String
    var trackTimeMillis: Int
    var trackViewUrl: String
}
