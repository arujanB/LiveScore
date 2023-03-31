//
//  MainScoresViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 27.03.2023.
//

import UIKit

class MainScoresViewController: UIViewController {
    //enum segment
    private var mediaType: ScoreSegment = .today
    
    var dateArray: [DateModel] = []
    
    var apiCaller = APICaller()
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
    private lazy var containerView = UIView()
    
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
    
    private var overviewVC = SectionHeaderDetailOverviewVC()
    private var matchesVC = SectionHeaderDetailMatchesVC()
    private var tableVC = ScoresViewController()
    private var playerVC = SectionHeaderDetailPlayerVC()
    private var teamVC = SectionHeaderDetailTeamVC()

    @objc func segmentControlValuChanged(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            addChildViewControllers(overviewVC)
            
            removeChildViewControllers(matchesVC)
            removeChildViewControllers(tableVC)
            removeChildViewControllers(playerVC)
            removeChildViewControllers(teamVC)
        }else if sender.selectedSegmentIndex == 1 {
            addChildViewControllers(matchesVC)
            
            removeChildViewControllers(overviewVC)
            removeChildViewControllers(tableVC)
            removeChildViewControllers(playerVC)
            removeChildViewControllers(teamVC)
        }else if sender.selectedSegmentIndex == 2 {
            addChildViewControllers(tableVC)
            
            removeChildViewControllers(overviewVC)
            removeChildViewControllers(matchesVC)
            removeChildViewControllers(playerVC)
            removeChildViewControllers(teamVC)
        }else if sender.selectedSegmentIndex == 3 {
            addChildViewControllers(playerVC)
            
            removeChildViewControllers(overviewVC)
            removeChildViewControllers(matchesVC)
            removeChildViewControllers(tableVC)
            removeChildViewControllers(teamVC)
        }else {
            addChildViewControllers(teamVC)
            
            removeChildViewControllers(overviewVC)
            removeChildViewControllers(matchesVC)
            removeChildViewControllers(playerVC)
            removeChildViewControllers(tableVC)
        }
    }
    
    //Change VC
    private func addChildViewControllers(_ viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }

    private func removeChildViewControllers(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        setUpViews()
        setUpConstrains()
        
        segmentControll.selectedSegmentIndex = 2
        
        buttonICON.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        
    }
    var dateTo : String?
    
    @objc func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        let alert = UIAlertController(title: "Select Date", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)

        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            // Handle date selection
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: selectedDate)
            self.dateTo = formattedDate
            
//            self.tableVC.dateString = formattedDate
            
            print(formattedDate)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(doneAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Date
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
            
            let data = DateModel(week: weekdayString.uppercased(), day: "\(day)", month: monthString.uppercased())
            print(data)
            
            dateData.append(data)
        }
        
        return dateData
    }

}

//MARK: - setUpViews & setUpConstrains
extension MainScoresViewController{
    func setUpViews() {
        view.addSubview(dateStackView)
        view.addSubview(line)
        view.addSubview(containerView)
    }
    
    func setUpConstrains(){
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
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
//            make.bottom.equalTo(tableView.snp.top).multipliedBy(0.7)
        }
    }
}
