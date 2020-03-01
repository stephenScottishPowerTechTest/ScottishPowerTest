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
    
    weak var trackFlowCoordinationDelegate: TracksFlowCoordination?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = NSLocalizedString("Rock Tracks", comment: "Rock Tracks")
        self.view.backgroundColor = UIColor.lightGray
        self.configureCollectionView()
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
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}


//Putting this here for now. With larger view controllers I'd split this out into it's own file or class

extension TrackListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000 //1000 just now for testing purposes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! TrackSummaryCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let exampleTrack = TrackDetails(artistName: "Test",
                                        trackName: "Track",
                                        trackPrice: 0.99,
                                        releaseDate: Date(),
                                        artworkUrl100: "https://example.com",
                                        trackTimeMillis: 100,
                                        trackViewUrl: "https://example.com")
        
        self.trackFlowCoordinationDelegate?.detailsRequested(from: self, trackDetails: exampleTrack)
    }
}
