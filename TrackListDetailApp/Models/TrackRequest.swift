//
//  TrackRequest.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import Foundation

enum NetworkError: Error {
    //Error cases
    case badURL
    case noFetched
}

struct TrackRequest {
    let url: URL
    
    init() {
        let url = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
        //Convert String to URL type
        guard let resourceURL = URL(string: url) else {fatalError()}
        self.url = resourceURL
        
    }
    //Fetching data from URL, return array of Track objects
    func getTracks(completion: @escaping(Result<[Track], NetworkError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: self.url) {data, _, _ in
            
            guard let jsonData = data else {
                completion(.failure(.badURL))
                return
            }
        
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(TrackResponse.self, from: jsonData)
                let result = response.results
                //Return data
                completion(.success(result))
            } catch {
                //Error handlers
                completion(.failure(.noFetched))
            }
        }
        
        dataTask.resume()
    }
}
