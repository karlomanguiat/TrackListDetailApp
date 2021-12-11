//
//  TrackListTableViewCell.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import UIKit

class TrackListTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var favoriteDot: UIImageView! // --> Heart near Image 
    
    var track: Track!
    var trackKey: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Configure cell values
    func configure() {
        if let name = track.trackName {
            self.nameLabel.text = name
            self.trackKey = name
        } else {
            if let collectionName = track.collectionName {
                self.nameLabel.text = collectionName
                self.trackKey = collectionName
            } else {
                self.nameLabel.text = "Title not found."
                self.trackKey = ""
            }
        }
        
        if let artistName = track.artistName {
            self.artistLabel.text = artistName.uppercased()
        }
        
        if let releaseDate = track.releaseDate {
            self.genreLabel.text = String(format: "%@ • %@", track.primaryGenreName, formatToDate(dateString: releaseDate))
        } else {
            self.genreLabel.text = track.primaryGenreName
        }
        
        
        self.artworkImageView.loadImageUsingCacheWithUrlString(track.artworkUrl100)
        
        if let price = track.trackPrice {
            self.priceLabel.text = String(format:"BUY FOR $%.2f >", price)
            self.priceLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        } else {
            if let collectionPrice = track.collectionPrice {
                self.priceLabel.text = String(format:"BUY COLLECTION FOR $%.2f >", collectionPrice)
                self.priceLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .semibold)
            } else {
                self.priceLabel.text = String(format:"BUY FOR $%.2f >", 0.0)
            }
        }
        
        checkIfFavorite()
    }
    
    //Format date
    func formatToDate(dateString: String) -> String {
        if (!dateString.isEmpty) {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            if let date = inputFormatter.date(from: dateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy"
                return outputFormatter.string(from: date)
            }
            return ""
            

        } else {
            return ""
        }
    }
    
    // Loads the heart button if favorite using trackName as key in user defaults
    func checkIfFavorite() {
        let favorite = UserDefaults.standard.bool(forKey: self.trackKey)
        if (favorite) {
            self.favoriteDot.isHidden = false
        } else {
            self.favoriteDot.isHidden = true
        }
    }
    
}
