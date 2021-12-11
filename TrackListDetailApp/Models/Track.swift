//
//  Track.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import UIKit
import Foundation

// Track Model Object
struct Track: Codable {
    let trackName: String?
    let artistName: String?
    let artworkUrl30: String?
    let artworkUrl60, artworkUrl100: String
    let trackPrice: Double?
    let collectionPrice: Double?
    let primaryGenreName: String
    let collectionName: String?
    let longDescription: String?
    let releaseDate: String?
    
    var artworkImage: UIImage!

    enum CodingKeys: String, CodingKey {
        case trackName, artistName, artworkUrl30, artworkUrl60, artworkUrl100, trackPrice, collectionPrice, primaryGenreName, longDescription, collectionName, releaseDate
    }
}
