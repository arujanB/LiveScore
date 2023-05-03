//
//  FavoritesTableVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 20.04.2023.
//

import UIKit

class FavoritesTableVC: UIViewController {
    let apiCaller = APICaller()
    
    var id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(SectionHeaderDetailTableViewCell.self, forCellReuseIdentifier: SectionHeaderDetailTableViewCell.IDENTIFIER)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    //get Data TEAM STATS from API
    private var favoritesSectionDataTable: [FavoritesDatum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstrains()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //API team Stats
        self.apiCaller.fetchRequestFavoritesSection (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.favoritesSectionDataTable = values
                self.tableView.reloadData()
            }
        },  tourId: id)
        
    }
    
    
}

//MARK: - TableView DataSource
extension FavoritesTableVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return favoritesSectionDataTable.count
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesSectionDataTable[section].sortedByPointTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderDetailTableViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderDetailTableViewCell
        cell.backgroundColor = .clear
        cell.setInfo(with: favoritesSectionDataTable[indexPath.section].sortedByPointTeams[indexPath.row])
        return cell
    }
}

//MARK: - TableView Delegate
extension FavoritesTableVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderTableView()
        view.setName(groupName: favoritesSectionDataTable[section].groupName)
        return view
    }
}

//MARK: - setUpViews & setUpConstarins
extension FavoritesTableVC {
    func setUpViews() {
        view.addSubview(tableView)
    }
    
    func setUpConstrains() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
    }
}
