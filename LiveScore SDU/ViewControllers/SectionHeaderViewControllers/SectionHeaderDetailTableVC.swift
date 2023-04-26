//
//  SectionHeaderDetailTableVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 25.03.2023.
//

import UIKit

class SectionHeaderDetailTableVC: UIViewController {
    let apiCaller = APICaller()
    
    var tourId: Int
    var grouId: Int
    
    init(tourId: Int, grouId: Int) {
        self.tourId = tourId
        self.grouId = grouId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let refreshControl = UIRefreshControl()
    
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
    private var tableData: [FavoritesDatum] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstrains()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = .orange
        
        //API team Stats
        self.apiCaller.fetchRequestTable (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.tableData = values
                self.tableView.reloadData()
            }
        }, grouId: grouId,  tourId: tourId)
        
    }

    @objc private func refreshTable() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

}

//MARK: - TableView DataSource
extension SectionHeaderDetailTableVC: UITableViewDataSource {
    
    //section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Team"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Database.playerInfoArray.count
        if !tableData.isEmpty {
            return tableData[0].sortedByPointTeams.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderDetailTableViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderDetailTableViewCell
        cell.backgroundColor = .clear
        cell.setInfo(with: tableData[0].sortedByPointTeams[indexPath.row])
        return cell
    }
}

//MARK: - tableView Delegate
extension SectionHeaderDetailTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderTableView()
        return view
    }
}

//MARK: - setUpViews & setUpConstarins
extension SectionHeaderDetailTableVC {
    func setUpViews() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    func setUpConstrains() {
        tableView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
////            make.height.equalToSuperview().multipliedBy(0.5)
//            make.height.equalTo(300)
//            make.width.equalToSuperview().inset(20)
            
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
    }
}
