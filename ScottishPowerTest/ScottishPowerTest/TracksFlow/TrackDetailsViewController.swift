//
//  TrackDetailsViewController.swift
//  ScottishPowerTest
//
//  Created by Stephen  on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import UIKit

class TrackDetailsViewController: UIViewController, CoordinatedViewController {
    
    private var viewModel: TrackDetailsViewModel?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func styleView() {
        
        self.artistLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        self.stackView.setCustomSpacing(16.0, after: self.trackPriceLabel)
        self.moreDetailsButton.layer.cornerRadius = 8.0
        self.moreDetailsButton.layer.masksToBounds = true
        self.moreDetailsButton.backgroundColor = UIApplication.shared.keyWindow?.tintColor //This is a poor way of getting tint colour. I'd get it from a theme class or struct.
        self.moreDetailsButton.tintColor = UIColor.darkGray
        
        //Done this in order to see the button on contrasting background views
        self.backButton.layer.masksToBounds = true
        self.backButton.layer.cornerRadius = 8.0
        self.backButton.backgroundColor = UIColor(white: 0.4, alpha: 0.1)
        
        if #available(iOS 13.0, *) {
            self.backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        } else {
            self.backButton.setTitle("<", for: .normal) //a hack to go back on older devices. Ideally I'd have an asset here rather than SFSymbol
        }
    }
    
    @IBAction private func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureWithTrackDetails(trackDetails: TrackDetails) {
        
        self.trackNameLabel.text = trackDetails.trackName
        self.artistLabel.text = trackDetails.artistName
        self.trackPriceLabel.text = TrackDetailsViewController.currencyFormatter.string(from: NSDecimalNumber(decimal: trackDetails.trackPrice))
        self.durationLabel.text = DurationStringHelper.durationString(milliseconds: trackDetails.trackTimeMillis)
        self.releaseDateLabel.text = TrackDetailsViewController.dateFormatter.string(from: trackDetails.releaseDate)
        self.imageView.image = ImageManager.image(forURLString: trackDetails.artworkUrl100)
        
        self.downloadBetterImage()
    }
    
    private func downloadBetterImage() {
        
        //Scale to the width as that's the longest dimension
        let width = self.view.bounds.width
        if let biggerURL = self.viewModel?.biggerImageURL(width: Double(width)) {
            
            if let newImage = ImageManager.image(forURLString: biggerURL) {
                
                DispatchQueue.ensureMainThread {
                    
                    self.imageView.image = newImage
                }
                
            } else {
                
                self.imageView.loadImage(fromURLString: biggerURL)
            }
        }
    }
    
    public func bind(trackDetails: TrackDetails) {
        
        self.viewModel = TrackDetailsViewModel(details: trackDetails)
    }

    @IBAction func moreDetailsTapped(_ sender: Any) {
        
        /*
         Normally I'd use SFSafari controller from the SafariServices Module, however apple seem
         to no longer let you open music links on the phone in safari and instead force through to apple music.
         Doing it this way is a little cleaner when transitioning to apple music.
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
