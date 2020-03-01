//
//  TrackDetails.swift
//  ScottishPowerTest
//
//  Created by Stephen  on 01/03/2020.
//  Copyright © 2020 Stephen . All rights reserved.
//

import Foundation

//All that's required for the list of cells
protocol TrackSummary {
    
    var artistName: String { get }
    var trackName: String { get }
    var artworkUrl100: String { get }
    var trackPrice: Decimal { get }
}

struct TrackDetails: Codable, TrackSummary {
    
    var artistName: String
    var trackName: String
    var trackPrice: Decimal
    var releaseDate: Date
    var artworkUrl100: String
    var trackTimeMillis: Int
    var trackViewUrl: String
}
