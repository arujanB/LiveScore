//
//  MyCollectionDetailVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 16.03.2023.
//

import UIKit
import SnapKit
import Kingfisher

class MainCollectionDetailVC: UIViewController {
    static let IDENTIFIER = "MyCollectionDetailVC"
    
    var mainDataCellData: MainCellData?
    var events: [Event] = []
    
    init(model: MainCellData) {
        self.mainDataCellData = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private lazy var group1NameString = mainDataCell?.team1
    
    private lazy var group1Name = groupName(group: mainDataCellData!.team1)
    private lazy var group2Name = groupName(group: mainDataCellData!.team2)
    
    private lazy var group1Img = groupImg(img: mainDataCellData!.team1Logo)
    private lazy var group2Img = groupImg(img: mainDataCellData!.team2Logo)
    
    private lazy var nameLogo1: UIStackView = logoNameStackView(logo: group1Img, name: group1Name)
    private lazy var nameLogo2: UIStackView = logoNameStackView(logo: group2Img, name: group2Name)
   
    private lazy var score: UILabel = {
        let label = UILabel()
        label.text = mainDataCellData!.gameScore
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        
        return label
    }()
    
    private lazy var fullTime: UILabel = {
        let label = UILabel()
        label.text = "Full Time"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        
        return label
    }()
    
    private lazy var scoreFullTime: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [score, fullTime])
        stackView.axis = .vertical
        stackView.spacing = 5
//        stackView.backgroundColor = .orange
        
        return stackView
    }()
    
    //goal info part
    
    private lazy var myGoalTableView1: UITableView = goalTableView()
    private lazy var myGoalTableView2: UITableView = goalTableView()
   
    private lazy var horizontalTopStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(nameLogo1)
        stackView.addArrangedSubview(scoreFullTime)
        stackView.addArrangedSubview(nameLogo2)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 50
//        stackView.backgroundColor = .systemPink
        
        return stackView
    }()
    
    private lazy var img: UIImageView = {
        var img = UIImageView()
        img.image = UIImage(systemName: "soccerball.inverse")
        img.tintColor = .gray
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var horizontalTopStackView2: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(myGoalTableView1)
//        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(myGoalTableView2)

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
//        stackView.backgroundColor = .yellow

        return stackView
    }()
    
    private lazy var verticaltalTopStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(horizontalTopStackView)
        stackView.addArrangedSubview(img)
        
        stackView.addArrangedSubview(horizontalTopStackView2)
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        stackView.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
//        stackView.backgroundColor = .blue
        stackView.layer.cornerRadius = 7
        
        return stackView
    }()
    
    private lazy var line: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        return view
    }()
    
    //MARK: - Main TableView
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainCollectionDetailInfoCell.self, forCellReuseIdentifier: MainCollectionDetailInfoCell.IDENTIFIER)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 7
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1).cgColor
        tableView.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        myGoalTableView1.dataSource = self
        myGoalTableView1.delegate = self
        
        myGoalTableView2.dataSource = self
        myGoalTableView2.delegate = self
        
        infoTableView.dataSource = self
//        infoTableView.delegate = self
        
        setUpViews()
        setUpConstrains()
        
        setNav()
        
        print(mainDataCellData)
        events = mainDataCellData!.events
        
        self.infoTableView.reloadData()
        self.myGoalTableView1.reloadData()
        self.myGoalTableView2.reloadData()
    }
    
    func groupName(group name:String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = name
        
        return label
    }
    func groupImg(img name: String) -> UIImageView {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
//        img.sizeThatFits(CGSize.init(width: 7, height: 5))
        
        let url = URL(string: name)!
        img.kf.setImage(with: url)
            
        return img
    }
    
    func logoNameStackView(logo: UIImageView, name: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [logo, name])
        stackView.axis = .vertical
        stackView.spacing = 7
//        stackView.backgroundColor = .orange
        stackView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        return stackView
    }
    
    func goalTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(MainCollectionDetailGoalCell.self, forCellReuseIdentifier: MainCollectionDetailGoalCell.IDENTIFIER)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        let cellHeight = CGFloat(20)
        let tableHeight = CGFloat(Database.gameScoreDataArray.count) * cellHeight
        tableView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
        
        return tableView
    }
    
    //MARK: - After Line
    
}

//MARK: - TableView DataSource
extension MainCollectionDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == infoTableView {
            return events.count
        }
        
        return mainDataCellData!.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == infoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionDetailInfoCell.IDENTIFIER, for: indexPath) as! MainCollectionDetailInfoCell
            cell.configure(with: events[indexPath.row], with: mainDataCellData!)
            return cell
        }else if tableView == myGoalTableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionDetailGoalCell.IDENTIFIER, for: indexPath) as! MainCollectionDetailGoalCell
            cell.configure1(with: events[indexPath.row], with: mainDataCellData!)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionDetailGoalCell.IDENTIFIER, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
    
}

//MARK: - TableView Delegate
extension MainCollectionDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == infoTableView{
//            return tableView.rowHeight
//        }
        return 20
    }
}

//MARK: - SetUpViews & setUPConstrains
extension MainCollectionDetailVC {
    func setUpViews(){
        view.addSubview(verticaltalTopStackView)
        view.addSubview(line)
        view.addSubview(infoTableView)
    }
    
    func setUpConstrains(){
        verticaltalTopStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        horizontalTopStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
        }
        
        horizontalTopStackView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        myGoalTableView1.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.2)
            make.leading.equalToSuperview()
        }
        img.snp.makeConstraints { make in
            make.top.equalTo(horizontalTopStackView.snp.bottom).offset(20)
            make.width.equalTo(21)
            make.height.equalTo(21)
            
            make.bottom.equalTo(myGoalTableView2.snp.top).inset(13)
        }
        myGoalTableView2.snp.makeConstraints { make in
            make.leading.equalTo(myGoalTableView1.snp.trailing)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2.2)
        }
        
        group1Img.snp.makeConstraints { make in
            make.size.equalTo(35)
        }
        group2Img.snp.makeConstraints { make in
            make.size.equalTo(35)
        }
        
        //after line
        line.snp.makeConstraints { make in
            make.top.equalTo(verticaltalTopStackView.snp.bottom).offset(17)
            make.width.equalToSuperview()
            make.height.equalTo(2)
        }
        
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(17)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}

//MARK: - Navigation
extension MainCollectionDetailVC {
    private func setNav() {
        createCustomNavigationBar()
        
        let audioRightButton = createCustomButton(
            imageName: "phone",
            selector: #selector(audioRightButtonTapped)
        )
        let videoRightButton = createCustomButton(
            imageName: "video",
            selector: #selector(videoRightButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [audioRightButton, videoRightButton]
    }
    
    @objc private func audioRightButtonTapped() {
        print("audioRightButtonTapped")
    }
    
    @objc private func videoRightButtonTapped() {
        print("videoRightButtonTapped")
    }
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
    
            let button = UIButton(type: .system)
            button.setImage(
                UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
                for: .normal
            )
            button.tintColor = .gray
            button.imageView?.contentMode = .scaleAspectFit
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.addTarget(self, action: selector, for: .touchUpInside)
    
            let menuBarItem = UIBarButtonItem(customView: button)
            return menuBarItem
        }
}
