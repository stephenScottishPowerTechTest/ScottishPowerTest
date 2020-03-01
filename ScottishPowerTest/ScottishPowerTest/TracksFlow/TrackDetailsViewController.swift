//
//  TrackDetailsViewController.swift
//  ScottishPowerTest
//
//  Created by Stephen  on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import UIKit

class TrackDetailsViewController: UIViewController, CoordinatedViewController {
    
    var viewModel: TrackDetailsViewModel?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var moreDetailsButton: UIButton!
    
    static let currencyFormatter = NumberFormatter.USCurrencyFormatter()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US") // another assumption as above
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let details = self.viewModel?.trackDetails {
            
            self.configureWithTrackDetails(trackDetails: details)
        }
        self.styleView()
    }
    
    private func styleView() {
        
        self.artistLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        self.stackView.setCustomSpacing(16.0, after: self.trackPriceLabel)
        self.moreDetailsButton.layer.cornerRadius = 8.0
        self.moreDetailsButton.layer.masksToBounds = true
        self.moreDetailsButton.backgroundColor = UIColor.lightGray
        self.moreDetailsButton.tintColor = UIColor.darkGray
    }
    
    private func configureWithTrackDetails(trackDetails: TrackDetails) {
        
        self.trackNameLabel.text = trackDetails.trackName
        self.artistLabel.text = trackDetails.artistName
        self.trackPriceLabel.text = TrackDetailsViewController.currencyFormatter.string(from: NSDecimalNumber(decimal: trackDetails.trackPrice))
        self.durationLabel.text = DurationStringHelper.durationString(milliseconds: trackDetails.trackTimeMillis)
        self.releaseDateLabel.text = TrackDetailsViewController.dateFormatter.string(from: trackDetails.releaseDate)
    }
    
    public func bind(trackDetails: TrackDetails) {
        
        self.viewModel = TrackDetailsViewModel(details: trackDetails)
    }

    @IBAction func moreDetailsTapped(_ sender: Any) {
        
        /*
         Personally I would use SFSafariViewController to launch while remaining in app, however the test specified launching the browser and I've taken this
         to mean that I should launch safari separately on device.
         Also note that I definitely wouldn't use web view as this is deprecated and would result in a rejection from app store review.
         */
        guard let details = self.viewModel?.trackDetails,
            let url = URL(string: details.trackViewUrl) else {
                
                let title = NSLocalizedString("Error", comment:"Error")
                let message = NSLocalizedString("This track does not seem to have a URL for more details.",
                                                comment: "This track does not seem to have a URL for more details.")
                let alertController = UIAlertController(title: title,
                                                        message: message,
                                                        preferredStyle: .alert)
                let okTitle = NSLocalizedString("OK", comment: "OK")
                let okAction = UIAlertAction(title: okTitle, style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
                
        }
        
            UIApplication.shared.open(url)
    }
}
