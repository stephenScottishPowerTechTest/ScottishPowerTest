//
//  TracksFlowCoordinator.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation
import UIKit

protocol TracksFlowCoordination: class {
    
    func detailsRequested(from viewController: UIViewController, trackDetails: TrackDetails)
}

class TracksFlowCoordinator: Coordinator {
    
    weak var presenter: UINavigationController?
    
    init(presenter: UINavigationController?) {
        
        self.presenter = presenter
    }
    
    func start() {
        
        guard let trackListVC = TrackListViewController.instantiate(storyboard: "TracksFlow", identifier: "TrackListViewController") else {
            debugPrint("Could not create Track List view controller")
            return
        }
        trackListVC.trackFlowCoordinationDelegate = self
        self.presenter?.pushViewController(trackListVC, animated: false)
    }
}

extension TracksFlowCoordinator: TracksFlowCoordination {
    
    func detailsRequested(from viewController: UIViewController, trackDetails: TrackDetails) {
        
        guard let detailsVC = TrackDetailsViewController.instantiate(storyboard: "TracksFlow",
                                                                     identifier: "TrackDetailsViewController") else {
            
            debugPrint("Could not create Track Details view controller.")
            return
        }
        //TODO: bind track details to the details VC.
        self.presenter?.pushViewController(detailsVC, animated: true)
    }
}
