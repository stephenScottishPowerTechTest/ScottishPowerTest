//
//  TracksListViewModel.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

protocol TracksListViewModelDelegate: class {
    
    func didRefreshData(errorMessage: String?)
}

class TracksListViewModel {
    
    var networkManager = NetworkManager()
    weak var delegate: TracksListViewModelDelegate?
    var tracks: [TrackDetails] = []
    
    init(delegate: TracksListViewModelDelegate) {
        
        self.delegate = delegate
    }
    
    /* I wouldn't necessarily do network calls in the view model. It's a discussion where is best to do the network calls, but for this use case I think here is probably the best in time available. */
    func refreshData() {
        
        networkManager.requestTrackList { [weak self] (response, error) in
            self?.tracks = response?.results ?? []
            self?.delegate?.didRefreshData(errorMessage: error?.localizedDescription)
        }
    }
}

