//
//  TrackListViewController.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController, CoordinatedViewController {
    
    //constants
    let cellSpacing = CGFloat(24)
    let cellInset = CGFloat(16)
    let cellIdentifier = String(describing: TrackSummaryCollectionViewCell.self)

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = NSLocalizedString("Rock Tracks", comment: "Rock Tracks")
        self.view.backgroundColor = UIColor.lightGray
        self.configureCollectionView()
    }
    
    func configureCollectionView() {
                
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
}
