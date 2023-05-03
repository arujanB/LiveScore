//
//  RefreshViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 04.03.2023.
//

import UIKit
import SnapKit

protocol Refreshable {
    func refresh()
}

class RefreshViewController: UIViewController {
//    var score = ScoresViewController()
//    let favorite = FavoritesViewController()
    
//    MARK: - Refresh
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(refreshControl)

//        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
//        refreshControl.tintColor = .orange
    }

//    @objc private func refreshTable() {
//        score.reload()
//        refreshControl.endRefreshing()
//    }



    //another version
    func refreshTapped(_ sender: Any) {
        for vc in tabBarController!.viewControllers! {
            // If view controller supports refreshing, call refresh method
            if let refreshableVC = vc as? Refreshable {
                refreshableVC.refresh()
            }
        }
    }

}








//class RefreshViewController: UIViewController {
//    let apiCaller = APICaller()
//
//    var id: Int
//
//    init(id: Int = 1) {
//        self.id = id
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let refreshControl = UIRefreshControl()
//
//    var allList: [[PlayerStatisticsDatum]] = []
//
//    private var playerStatisticsGoals: [PlayerStatisticsDatum] = []
//    private var playerStatisticsAssistsData: [PlayerStatisticsDatum] = []
//    private var playerStatisticsRedCardData: [PlayerStatisticsDatum] = []
//    private var playerStatisticsYellowCardData: [PlayerStatisticsDatum] = []
//
//    private lazy var array = ["ALL", "GOALS SCORED", "ASSISTS", "RED CARD", "YELLOW CARD"]
//
//    private lazy var collectionView: UICollectionView = {
//        var layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(SectionHeaderStatsCollectionViewCell.self, forCellWithReuseIdentifier: SectionHeaderStatsCollectionViewCell.IDENTIFIER)
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        return collectionView
//    }()
//
//    private lazy var tableView: UITableView = {
//        var tableView = UITableView()
//        tableView.backgroundColor = .clear
//        tableView.register(SectionHeaderPlayerTableViewCell.self, forCellReuseIdentifier: SectionHeaderPlayerTableViewCell.IDENTIFIER)
//        tableView.allowsSelection = false
//        tableView.showsVerticalScrollIndicator = false
//        tableView.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
//        tableView.layer.borderWidth = 1
//        tableView.layer.cornerRadius = 10
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
//        refreshControl.tintColor = .orange
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        selectedCategory = array[0]
//
//        tableView.dataSource = self
//
//        //connect with backpart
//        allFetchAPI()
//
//        setUpViews()
//        setUpConstrains()
//
//    }
//
//    @objc private func refreshTable() {
//        tableView.reloadData()
//        refreshControl.endRefreshing()
//    }
//
//    //for show the datas which you choose in collection cell
//    var selectedCollectionIndex: Int = 0
//    var selectedCategory: String = ""
//
//    //MARK: - Connect with BACK
//    func allFetchAPI(){
//
//        apiCaller.fetchRequestPS (completion: { [weak self] values in
//            DispatchQueue.main.async {
//                guard let self else { return }
//                self.playerStatisticsGoals = values
//                self.tableView.reloadData()
//            }
//        }, sectionName: APIStats.goals.rawValue, tournamentId: id)
//
//        apiCaller.fetchRequestPS (completion: { [weak self] values in
//            DispatchQueue.main.async {
//                guard let self else { return }
//                self.playerStatisticsAssistsData = values
//                self.tableView.reloadData()
//            }
//        }, sectionName: APIStats.assist.rawValue, tournamentId: id)
//
//        apiCaller.fetchRequestPS (completion: { [weak self] values in
//            DispatchQueue.main.async {
//                guard let self else { return }
//                self.playerStatisticsRedCardData = values
//                self.tableView.reloadData()
//            }
//        }, sectionName: APIStats.redCard.rawValue, tournamentId: id)
//
//        apiCaller.fetchRequestPS (completion: { [weak self] values in
//            DispatchQueue.main.async {
//                guard let self else { return }
//                self.playerStatisticsYellowCardData = values
//                self.tableView.reloadData()
//            }
//        }, sectionName: APIStats.yellowCard.rawValue, tournamentId: id)
//
//    }
//
//}
//
////MARK: - API Delegate
//extension RefreshViewController: AllPlayStatsData {
//    func didFetch(with: [PlayerStatisticsDatum]) {
//        allList.append(with)
//        print(allList)
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//
//}
//
////MARK: - collectionView DataSource
//extension RefreshViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return array.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionHeaderStatsCollectionViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderStatsCollectionViewCell
//        cell.configure(with: array[indexPath.item])
//        cell.layer.cornerRadius = 13
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = CGColor.init(red: 58, green: 58, blue: 58, alpha: 1)
//        if array[indexPath.row] == selectedCategory {
//            cell.backgroundColor = .gray
//        }else {
//            cell.backgroundColor = .clear
//        }
//        return cell
//    }
//
//}
//
////MARK: - CollectionView Delegate
//extension RefreshViewController: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedCollectionIndex = indexPath.row
//        selectedCategory = array[indexPath.row]
//
//        collectionView.reloadData()
//        tableView.reloadData()
//    }
//}
//
////MARK: - CollectionView Delegate: Cell Layout Size
//extension RefreshViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let label = UILabel()
//        label.text = array[indexPath.row]
//        label.sizeToFit()
//        return CGSize(width: label.frame.size.width + 3, height: collectionView.frame.size.height - 25)
//    }
//}
//
////MARK: - TableView DataSource
//extension RefreshViewController: UITableViewDataSource {
//    //section
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if selectedCollectionIndex != 0 {
//            return array[selectedCollectionIndex]
//        }
//        return array[section]
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if selectedCollectionIndex != 0{
//            return 1
//        }
//        return array.count
//    }
//
//    //cell
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        /*
//         ["ALL", "GOALS SCORED", "ASSISTS", "RED CARD", "YELLOW CARD"]
//         */
//        if selectedCollectionIndex != 0 {
//            if selectedCollectionIndex == 1 {
//                return playerStatisticsGoals.count
//            }else if selectedCollectionIndex == 2 {
//                return playerStatisticsAssistsData.count
//            }else if selectedCollectionIndex == 3 {
//                return playerStatisticsRedCardData.count
//            }else if selectedCollectionIndex == 4 {
//                return playerStatisticsYellowCardData.count
//            }
//        }else {
//            if section == 1 {
//                return playerStatisticsGoals.count
//            }else if section == 2 {
//                return playerStatisticsAssistsData.count
//            }else if section == 3 {
//                return playerStatisticsRedCardData.count
//            }else if section == 4 {
//                return playerStatisticsYellowCardData.count
//            }
//        }
//        return 0
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderPlayerTableViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderPlayerTableViewCell
//        cell.backgroundColor = .clear
//        if indexPath.section == 1 {
//            cell.setInfo(with: playerStatisticsGoals[indexPath.row])
//        }else if indexPath.section == 2 {
//            cell.setInfo(with: playerStatisticsAssistsData[indexPath.row])
//        }else if indexPath.section == 3 {
//            cell.setInfo(with: playerStatisticsRedCardData[indexPath.row])
//        }else if indexPath.section == 4 {
//            cell.setInfo(with: playerStatisticsYellowCardData[indexPath.row])
//        }else {
//            cell.setInfo(with: playerStatisticsGoals[indexPath.row])
//        }
//        return cell
//    }
//}
//
////MARK: - setUpViews & setUpConstrains {
//extension RefreshViewController{
//    func setUpViews(){
//        view.addSubview(collectionView)
//        view.addSubview(tableView)
//        tableView.addSubview(refreshControl)
//    }
//
//    func setUpConstrains(){
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.trailing.equalToSuperview().inset(17)
//            make.height.equalTo(50)
////            make.bottom.equalTo(tableView.snp.top).multipliedBy(0.7)
//        }
//
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom)
//            make.leading.trailing.equalToSuperview().inset(17)
//            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
//        }
//    }
//}
