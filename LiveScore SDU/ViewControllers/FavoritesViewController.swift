//
//  FavoritesViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 04.03.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let apiCaller = APICaller()
    private var mainGameDataScreen: [MainGameDataChangeNewDatum] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .brown
        
        apiCaller.fetchRequestMainGameChangeNewData(completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.mainGameDataScreen = values
            }
        }, date: "2023-03-06")
    }

}
