//
//  ViewController.swift
//  TrackListDetailApp
//
//  Created by Application Developer 7 on 12/11/21.
//

import UIKit

class TrackListViewController: UIViewController {
    
    @IBOutlet var trackListTableView: UITableView!  {
        didSet {
            trackListTableView.delegate = self
            trackListTableView.dataSource = self
            trackListTableView.tableFooterView = .init()
            let cellNib = UINib(nibName: "TrackListTableViewCell", bundle: .main)
            trackListTableView.register(cellNib, forCellReuseIdentifier: "TrackListTableViewCell")
        }
    }
    
    var viewModel = TrackListViewModel()
    
    /*
     Architecture: MVVM
     
     I opted to use MVVM, given I have limited time for this Coding Challenge, I wanted to determine if I'm comfortable enough to use this whenever I start a new coding project. I still don't if I did completely right, but there was an attempt.
     
     Instead of MVC, using MVVM provided a much cleaner code, and handling better logics and much transparent communication between the Controllers, Views and Models.
     
     It was also mentioned that one benefit of MVVM is improved testability of view controllers. The VCs no longer depends on the model layer, which makes them easier to test. 
     
    
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackListTableView.rowHeight = UITableView.automaticDimension
        trackListTableView.estimatedRowHeight = 320
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "New Releases"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.trackListTableView.reloadData()
    }
    
    // For fetching JSON Data for URL
    fileprivate func fetchData() {
        let request = TrackRequest()
        request.getTracks(completion: { [self] result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    print(data)
                    
                    self.viewModel.tracks = data
                    DispatchQueue.main.async {
                        self.trackListTableView.reloadData()
                    }
            }
        })
    }
}

// MARK: UITableViewDataSource
extension TrackListViewController: UITableViewDataSource {
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tracks.count
    }
    
    // Configuring Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackListTableViewCell") as! TrackListTableViewCell
        cell.track = viewModel.tracks[indexPath.row]
        cell.configure()
        return cell
    }
}

// MARK: UITableViewDelegate
extension TrackListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath, viewController: self)
    }
}
