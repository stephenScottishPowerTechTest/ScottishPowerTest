//
//  TracksResponse.swift
//  DynamicSizingCollectionView
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen Biggerstaff. All rights reserved.
//

import Foundation

class TracksResponse: Codable {
    
    var resultCount: Int
    var results: [TrackDetails]
}
