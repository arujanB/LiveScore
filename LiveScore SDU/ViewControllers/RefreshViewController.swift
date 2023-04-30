//
//  RefreshViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 04.03.2023.
//

import UIKit

class RefreshViewController: UIViewController {
    var score = ScoresViewController()
    let favorite = FavoritesViewController()
    
    //MARK: - Refresh
    //when you pull the tableView(to refresh)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(refreshControl)

        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = .orange
    }
    

    @objc private func refreshTable() {
        // Code to update your data
        score.reload()
        refreshControl.endRefreshing()
    }
    

}
