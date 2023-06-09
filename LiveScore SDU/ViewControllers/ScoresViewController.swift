//
//  SceneDelegate.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 28.02.2023.
//

import UIKit
import SnapKit

protocol ProtocolForHeader {
    func getHeaderData(with data: NameLocationData)
}

final class ScoresViewController: UIViewController {
    
    var apiCaller = APICaller()
    
    //Example connect and in future change to this data
    private var mainGameDataChangeNewData: [MainGameDataChangeNewDatum] = []
    
    var mainDataCell: MainCellData?
    
    var detailData:[MainCellData] = []
    
    //enum segment
    private var scoreSegmentEnum: ScoreSegment = .first
    
    var dateArray: [DateModel] = []
    
    //MARK: - Refresh
    //when you pull the tableView(to refresh)
    let refreshControl = UIRefreshControl()
    
    //MARK: - Date
    private lazy var buttonLive: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LIVE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            
        return button
    }()
    
    private lazy var buttonICON: UIButton = {
        let button = UIButton(type: .system)
        let myIcon = UIImage(systemName: "calendar")
        button.setImage(myIcon, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            
        return button
    }()
    
    private lazy var dateStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [buttonLive, segmentControll, buttonICON])
        
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var line: UIView = {
        var view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    //MARK: - SEGMENT
    private lazy var segmentControll: UISegmentedControl = {
        var segmentControll = UISegmentedControl(items: ["1", "2", "3", "4", "5"])
        segmentControll.selectedSegmentIndex = 2
        segmentControll.addTarget(self, action: #selector(segmentControlValuChanged(_:)), for: .valueChanged)
        
//        segmentControll.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
        
        //change color
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: UIControl.State.selected)
        segmentControll.removeBorders()
        
        //size
        let font = UIFont.boldSystemFont(ofSize: 10)
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        
        return segmentControll
    }()
    
    //MARK: - TableView
    private let myTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.IDENTIFIER)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var emptyText: UILabel = {
        var view = UILabel()
        view.text = "No match today:)"
        return view
    }()
    
    var selectedSegmentIndex: Int = 0
    var selectedCategory: String = ""
    
    private var dateModels: [DateModel] = []
    
    @objc func segmentControlValuChanged(_ sender: UISegmentedControl){
        
        if buttonLive.backgroundColor == .orange {
            buttonLive.backgroundColor = .white
            segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: UIControl.State.selected)
        }
        
        guard sender.selectedSegmentIndex < dateModels.count else { return }
        
        selectedSegmentIndex = sender.selectedSegmentIndex
        let dateModel = dateModels[selectedSegmentIndex]
        let apiDate = dateModel.apiDateText
        
        apiCaller.fetchRequestMainGameChangeNewData(completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.mainGameDataChangeNewData = values
                
                if values.count == 0 {
                    self.emptyText.text = "No matches today:)"
                    self.myTableView.addSubview(self.emptyText)
                    self.emptyText.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                    }
                } else {
                    self.emptyText.text = ""
                }
                
                print("NEW DATA IN SECTION\(self.mainGameDataChangeNewData)")
                self.myTableView.reloadData()
            }
        }, date: apiDate)
        
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchData()
        fetchMainCollectionDetailVCAPI()
        
        segmentControll.selectedSegmentIndex = 2
        buttonICON.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        buttonLive.addTarget(self, action: #selector(showLive), for: .touchUpInside)
        
        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        setUpView()
        setUPConstrains()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        setupSegmentTitles(date: Date())
        print("ARUZHAN\(mainGameDataChangeNewData)")
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = .orange
        
        //to show automatically
        apiCaller.fetchRequestMainGameChangeNewData(completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.mainGameDataChangeNewData = values
                
                if values.count == 0 {
                    self.emptyText.text = "No matches today:)"
                    self.myTableView.addSubview(self.emptyText)
                    self.emptyText.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                    }
                } else {
                    self.emptyText.text = ""
                }
                
                print("NEW DATA IN SECTION\(self.mainGameDataChangeNewData)")
                self.myTableView.reloadData()
            }
        }, date: dateModels[2].apiDateText)
        
        myTableView.reloadData()
    }
    
    @objc private func refreshTable() {
        // Code to update your data
        segmentControlValuChanged(segmentControll)
        myTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func reload() {
        segmentControlValuChanged(segmentControll)
        myTableView.reloadData()
//        refreshControl.endRefreshing()
    }
    
    private func setupSegmentTitles(date: Date) {
        let dateModels = makeDateModels(from: date)
        self.dateModels = dateModels
        
        for i in 0..<dateModels.count {
            let dateModel = dateModels[i]
            segmentControll.setTitle(dateModel.title, forSegmentAt: i)
        }
    }
    
    //MARK: - Button LIVE
    @objc func showLive() {
//        var lineOrange: UIView = {
//            var view = UIView()
//            view.backgroundColor = .orange
//            return view
//        }()
//        view.addSubview(lineOrange)
//        lineOrange.snp.makeConstraints { make in
//            make.height.equalTo(10)
//            make.width.equalToSuperview()
//            make.top.equalTo(line.snp.bottom).offset(10)
//        }
        segmentControll.selectedSegmentIndex = UISegmentedControl.noSegment
        apiCaller.fetchRequestLive(completion: { values in
            DispatchQueue.main.async {
                self.mainGameDataChangeNewData = values
                
                if values.count == 0 {
                    self.emptyText.text = "No LIVE matches today:)"
                    self.myTableView.addSubview(self.emptyText)
                    self.emptyText.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                    }
                } else {
                    self.emptyText.text = ""
                }
                
                print("LIVE\(self.mainGameDataChangeNewData)")
                self.myTableView.reloadData()
            }
        })
        
        if buttonLive.backgroundColor == .white {
            buttonLive.backgroundColor = .orange
            segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        }
    }
    
    //MARK: - Date Picker
    @objc func showDatePicker() {
        print("CLICKED showDatePicker")
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date

        let alert = UIAlertController(title: "", message: "\n", preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }

        let doneAction = UIAlertAction(title: "Done", style: .default) { [self] _ in
            // Handle date selection
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: selectedDate)
            setupSegmentTitles(date: selectedDate)
            segmentControll.selectedSegmentIndex = 2
            apiCaller.fetchRequestMainGameChangeNewData(completion: { [weak self] values in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.mainGameDataChangeNewData = values
                    
                    if values.count == 0 {
                        self.emptyText.text = "No matches today:)"
                        self.myTableView.addSubview(self.emptyText)
                        self.emptyText.snp.makeConstraints { make in
                            make.center.equalToSuperview()
                        }
                    } else {
                        self.emptyText.text = ""
                    }
                    
                    print("NEW DATA DATE PICKER\(self.mainGameDataChangeNewData)")
                    myTableView.reloadData()
                }
            }, date: formattedDate)
            print(mainGameDataChangeNewData)
            print(formattedDate)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Selected Data from calendar
    func getDates(from date: Date) -> [Date] {
        let currentDate = date
        var array:[Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for index in -2..<0 {
            let yesterday = Calendar.current.date(byAdding: .day, value: index, to: currentDate)
            array.append(yesterday!)
        }
        
        array.append(currentDate)
        
        for index in 1..<3{
            let future = Calendar.current.date(byAdding: .day, value: index, to: currentDate)
            array.append(future!)
        }
        
        return array
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date).uppercased()
    }
    
    func formatApiDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func makeDateModels(from date: Date) -> [DateModel] {
        let dates = getDates(from: date)
        let dateModels = dates.map {
            let title = formatDate($0)
            let apiDate = formatApiDate($0)
            return DateModel(title: title, apiDateText: apiDate)
        }
        return dateModels
    }
    
    func fetchMainCollectionDetailVCAPI() {
//        var dataa: MainCellData
        
        apiCaller.fetchRequestMainCell(completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.mainDataCell = values
//                guard let data = self.mainDataCell else { fatalError("ERROR DATA")}
                print("CELL\(self.mainDataCell)")
                guard let data = self.mainDataCell else { fatalError("ERROR DATA")}
                print("DATA: \(data)")
            }
        }, protocolId: 1)
        
    }
    
}

//MARK: - tableView DataSource
extension ScoresViewController: UITableViewDataSource{
    //section
    func numberOfSections(in tableView: UITableView) -> Int {
        print("COUNT ARUZHAN\(mainGameDataChangeNewData.count)")
        return mainGameDataChangeNewData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        mainGameDataChangeNewData[section].groupName
    }
    
    //sectionHeader
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHearderView(model: self.mainGameDataChangeNewData[section])
        print("mainGameDataChangeNewData:\(mainGameDataChangeNewData)")
        view.setInfo(with: mainGameDataChangeNewData[section])
        
        view.outputDetail = { [weak self] data, tournId in
            guard let self else { return }
            
            let vc = SectionHeaderDetailMainVC(model: self.mainGameDataChangeNewData[section])
//            vc.dataTakeForTabHeader = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return view
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return mainGameDataChangeNewData[section].games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.IDENTIFIER, for: indexPath) as! MainTableViewCell
//        cell.setNameLabel(with: row[indexPath.row])
        cell.backgroundColor = .clear

        cell.scoreEnum = scoreSegmentEnum
        cell.selectedCategoryScreen = selectedCategory
        cell.games = mainGameDataChangeNewData[indexPath.section].games
        
        //MARK: - MainCollectionDetailVC
        cell.outputDetail = { id in
            self.apiCaller.fetchRequestMainCell(completion: { [weak self] values in
                DispatchQueue.main.async {
                    guard let self else { return }
//                    self.mainDataCell?.protocolId = self.mainGameDataScreen[id].protocolID
                    self.mainDataCell?.protocolId = self.mainGameDataChangeNewData[indexPath.section].games[id].protocolID
                    let vc = MainCollectionDetailVC(model: values)
                    self.navigationController?.pushViewController(vc, animated: true)
                    guard let data = self.mainDataCell else { fatalError("ERROR DATA")}
                    print("DATA: \(data)")
                }
            }, protocolId: self.mainGameDataChangeNewData[indexPath.section].games[id].protocolID)
        }
        
        cell.reload()
        
        return cell
    }
}

//MARK: - TableView Delegate
extension ScoresViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 80 * CGFloat(mainGameDataChangeNewData[indexPath.section].games.count)
    }
}

//MARK: - setUpView and setUPConstrains
private extension ScoresViewController {
    func setUpView() {
        view.addSubview(dateStackView)
        view.addSubview(line)
        view.addSubview(myTableView)
        myTableView.addSubview(refreshControl)
    }
    
    func setUPConstrains() {
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(7)
            make.height.equalTo(30)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(3)
        }
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(7)
            make.bottom.equalToSuperview()
//            make.height.equalTo(500)
//            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }

    }
    
}
