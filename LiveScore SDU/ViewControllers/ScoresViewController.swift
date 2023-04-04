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
    var mainGameData: [MainGameDatum] = []
    var mainGameDataScreen: [MainGameDatum] = []
    
    //enum segment
    private var scoreSegmentEnum: ScoreSegment = .first
    
    var dateArray: [DateModel] = []
    
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
        button.setTitle("CAL", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        
        button.backgroundColor = .white
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
//        segmentControll.setTitle("\(buttonLive)", forSegmentAt: 0)
        segmentControll.setTitle("\(createBTN()[1].month) \(createBTN()[1].day)", forSegmentAt: 0)
        segmentControll.setTitle("\(createBTN()[2].month) \(createBTN()[2].day)", forSegmentAt: 1)
        segmentControll.setTitle("\(createBTN()[3].month) \(createBTN()[3].day)", forSegmentAt: 2)
        segmentControll.setTitle("\(createBTN()[4].month) \(createBTN()[4].day)", forSegmentAt: 3)
        segmentControll.setTitle("\(createBTN()[5].month) \(createBTN()[5].day)", forSegmentAt: 4)
        
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
        return tableView
    }()
    
    var selectedSegmentIndex: Int = 0
    var selectedCategory: String = ""
    
    @objc func segmentControlValuChanged(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            selectedSegmentIndex = 0
            selectedCategory = "\(createBTN()[1].year)-\(createBTN()[1].monthNumber)-\(createBTN()[1].dayWith0)"
            
            scoreSegmentEnum = .first
            self.myTableView.reloadSections([0], with: .none)
        }else if sender.selectedSegmentIndex == 1 {
            selectedSegmentIndex = 1
            selectedCategory = "\(createBTN()[2].year)-\(createBTN()[2].monthNumber)-\(createBTN()[2].dayWith0)"
            
            scoreSegmentEnum = .yesterday
            
            self.myTableView.reloadSections([0], with: .none)
        }else if sender.selectedSegmentIndex == 2 {
            selectedSegmentIndex = 2
            selectedCategory = "\(createBTN()[3].year)-\(createBTN()[3].monthNumber)-\(createBTN()[3].dayWith0)"
            
            scoreSegmentEnum = .today
            self.myTableView.reloadSections([0], with: .none)
        }else if sender.selectedSegmentIndex == 3 {
            selectedSegmentIndex = 3
            selectedCategory = "\(createBTN()[4].year)-\(createBTN()[4].monthNumber)-\(createBTN()[4].dayWith0)"
            
            scoreSegmentEnum = .tomorrow
            self.myTableView.reloadSections([0], with: .none)
        }else {
            selectedSegmentIndex = 4
            selectedCategory = "\(createBTN()[5].year)-\(createBTN()[5].monthNumber)-\(createBTN()[5].dayWith0)"
            
            scoreSegmentEnum = .last
            self.myTableView.reloadSections([0], with: .none)
        }
        
        selectedSegmentIndex = sender.selectedSegmentIndex
        selectedCategory = "\(createBTN()[selectedSegmentIndex].year)-\(createBTN()[selectedSegmentIndex].monthNumber)-\(createBTN()[selectedSegmentIndex].dayWith0)"
        
        apiCaller.fetchRequestMainGameChange(completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.mainGameDataScreen = values
                self.myTableView.reloadSections([0], with: .none)
//                self.myTableView.reloadData()
                print("screen\(self.mainGameDataScreen)")
            }
        }, date: selectedCategory)
        self.myTableView.reloadSections([0], with: .none)
    }
    
    
    //MARK: - Main SectionButton
    private lazy var sectionButton: UIButton = {
        var button = UIButton()
        return button
    }()
    
//    var dateString: String? {
//        didSet {
//            apiCaller.fetchRequestMainGame(completion: { [weak self] values in
//                DispatchQueue.main.async {
//                    guard let self else { return }
//                    self.mainGameData = values
//                    self.myTableView.reloadData()
//                }
//            }, date: dateString!)
//            print(dateString!)
//        }
//    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchData()
        
        segmentControll.selectedSegmentIndex = 2
        buttonICON.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        
        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        setUpView()
        setUPConstrains()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
//        apiCaller.fetchRequestMainGame(completion: { [weak self] values in
//            DispatchQueue.main.async {
//                guard let self else { return }
//                self.mainGameData = values
//                self.myTableView.reloadSections([0], with: .none)
////                self.myTableView.reloadData()
//                print("men\(self.mainGameData)")
//
//            }
//        }, date: dateTo!)

    }
    
//    var dateTo : String? {
//        didSet {
//            if let myOptional = dateTo {
//                apiCaller.fetchRequestMainGame(completion: { [weak self] values in
//                    DispatchQueue.main.async {
//                        guard let self else { return }
//                        self.mainGameData = values
//                        self.myTableView.reloadSections([0], with: .none)
//        //                self.myTableView.reloadData()
//                        print("men\(self.mainGameData)")
//
//                    }
//                }, date: myOptional)
//             }
//        }
//    }
    
    @objc func showDatePicker() {
        print("CLICKED showDatePicker")
        print("BEFORE:\(mainGameData)")
        mainGameData.removeAll()
        print("AFTER:\(mainGameData)")
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        let alert = UIAlertController(title: "Select Date", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)

        let doneAction = UIAlertAction(title: "Done", style: .default) { [self] _ in
            // Handle date selection
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: selectedDate)
//            self.dateTo = formattedDate
            
            apiCaller.fetchRequestMainGame(completion: { [weak self] values in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.mainGameData.append(contentsOf: values)
                    self.myTableView.reloadSections([0], with: .none)
                    print("men\(self.mainGameData)")

                }
            }, date: formattedDate)
            
            print(formattedDate)
//            print("DateTo:\(String(describing: self.dateTo))")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Date Dynamic for Segment
    var dateData: [DateModel] = []
    
    func getListOfDate() -> [Date] {
        let currentDate = Date()
        var array:[Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for index in -3..<0 {
            let yesterday = Calendar.current.date(byAdding: .day, value: index, to: currentDate)
    //        let dateString = dateFormatter.string(from: yesterday!)
            array.append(yesterday!)
        }
        
    //    var currentDateString: String = dateFormatter.string(from: currentDate)
        array.append(currentDate)
        
        for index in 1..<4{
            let future = Calendar.current.date(byAdding: .day, value: index, to: currentDate)
    //        let dateString = dateFormatter.string(from: future!)
            array.append(future!)
        }
        
        return array
    }

    func createBTN() -> [DateModel]{
        let array = getListOfDate()
        
        for date in array {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "MMM"
            let monthString = dateFormatter.string(from: date)
            print(monthString)
            
            let calendar = Calendar.current
            dateFormatter.dateFormat = "EEE"
        //    let weekday = calendar.component(.weekday, from: date)
            let weekdayString = dateFormatter.string(from: date)
            let day = calendar.component(.day, from: date)
            print(day)
            
            print(weekdayString)
            
            let year = calendar.component(.year, from: date) // extract the year component from the date
            print(year)
            
            let monthNumber = String(format: "%02d", Calendar.current.component(.month, from: date))
            print(monthNumber) // Output: "04"
            
            let dayNumber = String(format: "%02d", day)
            print("DAY with 0: \(dayNumber)") // Ex: if day 4 -> give 04
            
            let data = DateModel(week: weekdayString.uppercased(), day: "\(day)", month: monthString.uppercased(), year: "\(year)", monthNumber: monthNumber, dayWith0: dayNumber)
            print(data)
            
            dateData.append(data)
        }
        
        return dateData
    }
    
}

//MARK: - tableView DataSource
extension ScoresViewController: UITableViewDataSource{
    //section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Database.nameLocationDataArray[0].footballName
    }
    
    //sectionHeader
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHearderView()
        view.setInfo(with: Database.nameLocationDataArray[section])
        
        view.outputDetail = { [weak self] data in
            let vc = SectionHeaderDetailMainVC()
            vc.dataTakeForTabHeader = data
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return view
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.IDENTIFIER, for: indexPath) as! MainTableViewCell
//        cell.setNameLabel(with: row[indexPath.row])
        cell.backgroundColor = .clear
        
//        cell.mainGameDataFromScore.removeAll()
        print("CELL: \(mainGameData)")
        print("MAIN CELL\(cell.mainGameDataFromScore)")
        print("Screen CELL\(cell.mainGameDataFromScoreScreen)")
        
        cell.scoreEnum = scoreSegmentEnum
        cell.selectedCategoryScreen = selectedCategory
        cell.mainGameDataFromScoreScreen = mainGameDataScreen
        
        print("mainGameDataScreen \(mainGameDataScreen)")
        cell.mainGameDataFromScore = mainGameData
        print("AFTER MAIN CELL\(cell.mainGameDataFromScore)")
        
        cell.outputDetail = { id in
            let vc = MainCollectionDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
            vc.protocolID = id
        }
        
        cell.reload()
        
        return cell
    }
}

//MARK: - TableView Delegate
extension ScoresViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
//        return 100 * CGFloat(Database.nameLocationDataArray.count)
    }
}

//MARK: - setUpView and setUPConstrains
private extension ScoresViewController {
    func setUpView() {
        view.addSubview(dateStackView)
        view.addSubview(line)
        view.addSubview(myTableView)
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
