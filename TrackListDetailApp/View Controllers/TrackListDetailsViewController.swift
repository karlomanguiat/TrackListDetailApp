//
//  TrackListDetailsViewController.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import Foundation
import UIKit

class TrackListDetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var buyButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    var track: Track!
    var trackKey: String!
    var isFavorite: Bool!
    
    override func viewDidLoad() {
        setUpTheme()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.isHidden = true
        
        self.favoriteButton.setImage(UIImage(named: "like"), for: .normal)
        self.favoriteButton.setImage(UIImage(named: "like-selected"), for: .selected)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // Set up theme and etc.
    func setUpTheme() {
        self.buyButton.backgroundColor = .clear
        self.buyButton.layer.cornerRadius = 5
        self.buyButton.layer.borderWidth = 1
        self.buyButton.layer.borderColor = UIColor.link.cgColor
    }
    
    // Load Track Values for UI
    func setUpViews() {
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
                self.title = ""
            }
        }
        
        self.artworkImageView.loadImageUsingCacheWithUrlString(track.artworkUrl100)
        self.artworkImageView.contentMode = .scaleAspectFit
        
        if let artistName = track.artistName {
            self.artistLabel.text = artistName.uppercased()
        }
        
        if let releaseDate = track.releaseDate {
            self.genreLabel.text = String(format: "%@ • %@", track.primaryGenreName, formatToDate(dateString: releaseDate))
        } else {
            self.genreLabel.text = track.primaryGenreName
        }
        
        if let description = track.longDescription {
            self.descriptionTextView.text = description
        } else {
            self.descriptionTextView.text = "No description found."
        }
        
        if let price = track.trackPrice {
            self.buyButton.setTitle(String(format:"BUY FOR $%.2f", price), for: .normal)
        } else {
            if let collectionPrice = track.collectionPrice {
                self.buyButton.setTitle(String(format:"BUY COLLECTION FOR $%.2f", collectionPrice), for: .normal)
            } else {
                self.buyButton.setTitle("BUY", for: .normal)
            }
        }
        
        // Check if
        checkIfFavorite()
    }
    
    //If back button pressed, instead of navbar
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // If favorite button pressed
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        
        if (self.favoriteButton.isSelected) {
            self.favoriteButton.isSelected = false
            self.isFavorite = false
        } else {
            self.favoriteButton.isSelected = true
            self.isFavorite = true
            
            let alert = UIAlertController(title: "Added to favorites", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        saveFavorite()
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
    
    // Save to user defaults if set to favorite
    func saveFavorite() {
        if (self.isFavorite) {
            UserDefaults.standard.set(true, forKey: self.trackKey)
        } else {
            UserDefaults.standard.set(false, forKey: self.trackKey)
        }
    }
    
    // Loads the heart button if favorite using trackName as key in user defaults
    func checkIfFavorite() {
        let favorite = UserDefaults.standard.bool(forKey: self.trackKey)
        if (favorite) {
            self.favoriteButton.isSelected = true
            self.isFavorite = true
        } else {
            self.favoriteButton.isSelected = false
            self.isFavorite = false
        }
    }
}
