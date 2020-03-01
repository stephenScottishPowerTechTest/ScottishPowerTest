//
//  TrackListViewController.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController, CoordinatedViewController {
    
    let customFlowLayout = DynamicSizingFlowLayout()
    
    let cellSpacing = CGFloat(24)
    let cellInset = CGFloat(16)
    let cellIdentifier = String(describing: TrackSummaryCollectionViewCell.self)
    
    var viewModel: TracksListViewModel?
    
    weak var trackFlowCoordinationDelegate: TracksFlowCoordination?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = NSLocalizedString("Rock Tracks", comment: "Rock Tracks")
        self.view.backgroundColor = UIColor.lightGray
        self.configureCollectionView()
        self.viewModel = TracksListViewModel(delegate: self)
        self.viewModel?.refreshData()
        
    }
    
    func configureCollectionView() {
      
        customFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        customFlowLayout.minimumInteritemSpacing = cellSpacing
        customFlowLayout.minimumLineSpacing = cellSpacing
        customFlowLayout.sectionInset = UIEdgeInsets(top: cellSpacing,
                                                     left: cellInset,
                                                     bottom: cellInset,
                                                     right: cellInset)
        
        collectionView.collectionViewLayout = customFlowLayout
        
        collectionView.backgroundColor = UIColor(red:0.95, green:0.96, blue:0.96, alpha:1.00) //Taken by dropper from Wireframes
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}


//Putting this here for now. With larger view controllers I'd split this out into it's own file or class

extension TrackListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel?.tracks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let track = self.viewModel?.tracks[indexPath.row] else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! TrackSummaryCollectionViewCell
        cell.configureForTrack(trackSummary: track)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let track = self.viewModel?.tracks[indexPath.row] {
            
            self.trackFlowCoordinationDelegate?.detailsRequested(from: self, trackDetails: track)
            
        } else {
            
            debugPrint("Error selecting track")
        }
    }
}

extension TrackListViewController: TracksListViewModelDelegate {
    
    func didRefreshData(errorMessage: String?) {
        
        if let message = errorMessage, message.isEmpty == false {
            //TODO: Show error alert
        }
        
        // We want to refresh either way so we aren't showing stale data
        DispatchQueue.ensureMainThread {
            self.collectionView.reloadData()
        }
    }
}
