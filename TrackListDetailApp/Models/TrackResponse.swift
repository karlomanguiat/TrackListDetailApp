//
//  TrackResponse.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import Foundation

struct TrackResponse: Codable {
    // JSON Model
    let resultCount: Int
    let results: [Track]
}
