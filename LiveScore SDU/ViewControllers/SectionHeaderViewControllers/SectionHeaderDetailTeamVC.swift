//
//  SectionHeaderDetailTeamVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 25.03.2023.
//

import UIKit
import SnapKit

final class SectionHeaderDetailTeamVC: UIViewController {
    let apiCaller = APICaller()
    
    private var teamStatisticsGoals: [TeamStatisticsDatum] = []
    private var teamStatisticsRedCardData: [TeamStatisticsDatum] = []
    private var teamStatisticsYellowCardData: [TeamStatisticsDatum] = []
    
    
    
    var allTeamStatisticsData: [TeamStatisticsDatum] = []
    
    var id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var array = ["ALL", "GOALS SCORED", "RED CARD", "YELLOW CARD"]
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SectionHeaderStatsCollectionViewCell.self, forCellWithReuseIdentifier: SectionHeaderStatsCollectionViewCell.IDENTIFIER)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(SectionHeaderTeamTableViewCell.self, forCellReuseIdentifier: SectionHeaderTeamTableViewCell.IDENTIFIER)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //connecting with backpart
        fetchAPI()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setUpViews()
        setUpConstrains()
        
        selectedCategory = array[0]
        print("This oneeee \(allTeamStatisticsData)")
    }
    
    var selectedCollectionIndex: Int = 0
    var selectedCategory: String = ""
    
    //MARK: - Connect with BACK
    func fetchAPI() {
        apiCaller.fetchRequestTSGoals (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.teamStatisticsGoals = values
                self.tableView.reloadData()
                self.allTeamStatisticsData += self.teamStatisticsGoals
            }
        }, id: id)
        
        //RedCard
        apiCaller.fetchRequestTS (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.teamStatisticsRedCardData = values
                self.tableView.reloadData()
            }
        }, sectionName: "red_cards", id: id)
        
        //YellowCard
        apiCaller.fetchRequestTS (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.teamStatisticsYellowCardData = values
                self.tableView.reloadData()
            }
        }, sectionName: "yellow_cards", id: id)
        
    }
    
}

//MARK: - CollectionView DataSource
extension SectionHeaderDetailTeamVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionHeaderStatsCollectionViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderStatsCollectionViewCell
//        cell.configure(with: array[indexPath.item])
        cell.layer.cornerRadius = 13
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor.init(red: 58, green: 58, blue: 58, alpha: 1)

        let category = array[indexPath.row]
        cell.configure(with: category)
        if category == selectedCategory {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }

}

//MARK: - CollectionView Delegate
extension SectionHeaderDetailTeamVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get the data for the selected item
        let category = array[indexPath.row]
        selectedCategory = category
                
        collectionView.reloadData()
        selectedCollectionIndex = indexPath.row
        tableView.reloadData()
    }
}

//MARK: - CollectionView Delegate: Cell Layout Size
extension SectionHeaderDetailTeamVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = array[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.size.width + 3, height: collectionView.frame.size.height - 25)
    }
}

//MARK: - TableView DataSource
extension SectionHeaderDetailTeamVC: UITableViewDataSource {
    //section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectedCollectionIndex != 0 {
            return array[selectedCollectionIndex]
        }
        return array[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedCollectionIndex != 0 {
            return 1
        }
        return array.count
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCollectionIndex != 0{
            if selectedCollectionIndex == 1 { //goal
                return teamStatisticsGoals.count
            }else if selectedCollectionIndex == 2 { //redcards
                return teamStatisticsRedCardData.count
            }else if selectedCollectionIndex == 3 { //yello cards
                return teamStatisticsYellowCardData.count
            }
        }else {
            if section == 1 { //goal
                return teamStatisticsGoals.count
            }else if section == 2 { //redcards
                return teamStatisticsRedCardData.count
            }else if section == 3 { //yello cards
                return teamStatisticsYellowCardData.count
            }
        }
        //all
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderTeamTableViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderTeamTableViewCell
        cell.backgroundColor = .clear
        if selectedCollectionIndex != 0 {
            
            if selectedCollectionIndex == 1 {
                cell.setInfo(with: teamStatisticsGoals[indexPath.row])
            }else if selectedCollectionIndex == 2 {
                cell.setInfo(with: teamStatisticsRedCardData[indexPath.row])
            }else if selectedCollectionIndex == 3 {
                cell.setInfo(with: teamStatisticsYellowCardData[indexPath.row])
            }
            
        }else {
            if indexPath.section == 1 {
                cell.setInfo(with: teamStatisticsGoals[indexPath.row])
            }else if indexPath.section == 2 {
                cell.setInfo(with: teamStatisticsRedCardData[indexPath.row])
            }else if indexPath.section == 3 {
                cell.setInfo(with: teamStatisticsYellowCardData[indexPath.row])
            }
        }
        
        return cell
    }
}

//MARK: - TableView Delegate
extension SectionHeaderDetailTeamVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderTeamView()
        
        if selectedCollectionIndex != 0 {
            
            if selectedCollectionIndex == 1 {
                view.setName(with: array[selectedCollectionIndex])
                return view
            }else if selectedCollectionIndex == 2 {
                view.setName(with: array[selectedCollectionIndex])
                return view
            }else if selectedCollectionIndex == 3 {
                view.setName(with: array[selectedCollectionIndex])
                return view
            }
            
        }
        
        view.setName(with: array[section])
        return view
    }
}

//MARK: - setUpViews & setUpConstrains {
extension SectionHeaderDetailTeamVC{
    func setUpViews(){
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func setUpConstrains(){
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(17)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(17)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
        }
    }
}
