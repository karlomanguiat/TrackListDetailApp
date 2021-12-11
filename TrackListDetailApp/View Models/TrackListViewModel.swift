//
//  TrackListViewModel.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import Foundation
import UIKit

class TrackListViewModel {
    
    var tracks: [Track] = []
    
    //Init view model contents
    init() {
        self.tracks = []
    }
    
    //If selected is selected
    func didSelectRow(at indexPath: IndexPath, viewController: UIViewController) {
        if let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "trackListDetailsID") as? TrackListDetailsViewController {
            
            detailsViewController.track = tracks[indexPath.row]
            if let navigator = viewController.navigationController {
                    navigator.pushViewController(detailsViewController, animated: true)
                }
            }
    }
}
