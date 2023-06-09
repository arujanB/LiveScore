//
//  SectionHeaderDetailPlayerVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 16.03.2023.
//

import UIKit
import SnapKit

class SectionHeaderDetailPlayerVC: UIViewController {
    let apiCaller = APICaller()
    
    var id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let refreshControl = UIRefreshControl()
    
    var allList: [[PlayerStatisticsDatum]] = []
    
    private var playerStatisticsGoals: [PlayerStatisticsDatum] = []
    private var playerStatisticsAssistsData: [PlayerStatisticsDatum] = []
    private var playerStatisticsRedCardData: [PlayerStatisticsDatum] = []
    private var playerStatisticsYellowCardData: [PlayerStatisticsDatum] = []
    
    private lazy var array = ["ALL", "GOALS SCORED", "ASSISTS", "RED CARD", "YELLOW CARD"]
    var sectionExpanded = [false, false, false, false, false]
    
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
        tableView.register(SectionHeaderPlayerTableViewCell.self, forCellReuseIdentifier: SectionHeaderPlayerTableViewCell.IDENTIFIER)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    lazy var emptyText: UILabel = {
        var view = UILabel()
        view.text = "No match today:)"
        return view
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        refreshControl.tintColor = .orange
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        selectedCategory = array[0]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //connect with backpart
        allFetchAPI()
        
        setUpViews()
        setUpConstrains()
        
    }
    
    @objc private func refreshTable() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //for show the datas which you choose in collection cell
    var selectedCollectionIndex: Int = 0
    var selectedCategory: String = ""
    
    //MARK: - Connect with BACK
    func allFetchAPI(){
        
        apiCaller.fetchRequestPS (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.playerStatisticsGoals = values
                self.tableView.reloadData()
            }
        }, sectionName: APIStats.goals.rawValue, tournamentId: id)
        
        apiCaller.fetchRequestPS (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.playerStatisticsAssistsData = values
                self.tableView.reloadData()
            }
        }, sectionName: APIStats.assist.rawValue, tournamentId: id)
        
        apiCaller.fetchRequestPS (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.playerStatisticsRedCardData = values
                self.tableView.reloadData()
            }
        }, sectionName: APIStats.redCard.rawValue, tournamentId: id)
        
        apiCaller.fetchRequestPS (completion: { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.playerStatisticsYellowCardData = values
                self.tableView.reloadData()
            }
        }, sectionName: APIStats.yellowCard.rawValue, tournamentId: id)
        
    }

}

//MARK: - API Delegate
extension SectionHeaderDetailPlayerVC: AllPlayStatsData {
    func didFetch(with: [PlayerStatisticsDatum]) {
        allList.append(with)
        print(allList)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - collectionView DataSource
extension SectionHeaderDetailPlayerVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionHeaderStatsCollectionViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderStatsCollectionViewCell
        cell.configure(with: array[indexPath.item])
//        cell.contentView.tag = indexPath.item // add tag here
        cell.layer.cornerRadius = 13
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor.init(red: 58, green: 58, blue: 58, alpha: 1)
        if array[indexPath.row] == selectedCategory {
            cell.backgroundColor = .gray
        }else {
            cell.backgroundColor = .clear
        }
        return cell
    }

}

//MARK: - CollectionView Delegate
extension SectionHeaderDetailPlayerVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCollectionIndex = indexPath.row
        selectedCategory = array[indexPath.row]
        
        collectionView.reloadData()
        tableView.reloadData()
    }
}

//MARK: - CollectionView Delegate: Cell Layout Size
extension SectionHeaderDetailPlayerVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = array[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.size.width + 3, height: collectionView.frame.size.height - 25)
    }
}

//MARK: - TableView DataSource
extension SectionHeaderDetailPlayerVC: UITableViewDataSource {
    //section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectedCollectionIndex != 0 {
            return array[selectedCollectionIndex]
        }
        return array[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedCollectionIndex != 0{
            return 1
        }
        return array.count
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         ["ALL", "GOALS SCORED", "ASSISTS", "RED CARD", "YELLOW CARD"]
         */
        if selectedCollectionIndex != 0 {
            if selectedCollectionIndex == 1 {
                return playerStatisticsGoals.count
            }else if selectedCollectionIndex == 2 {
                return playerStatisticsAssistsData.count
            }else if selectedCollectionIndex == 3 {
                return playerStatisticsRedCardData.count
            }else if selectedCollectionIndex == 4 {
                return playerStatisticsYellowCardData.count
            }
        }else {
            if section == 1 {
//                return playerStatisticsGoals.count
                return sectionExpanded[section] ? playerStatisticsGoals.count : 0
            }else if section == 2 {
//                return playerStatisticsAssistsData.count
                return sectionExpanded[section] ? playerStatisticsAssistsData.count : 0
            }else if section == 3 {
                return sectionExpanded[section] ? playerStatisticsRedCardData.count : 0
            }else if section == 4 {
                return sectionExpanded[section] ? playerStatisticsYellowCardData.count : 0
            }
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderPlayerTableViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderPlayerTableViewCell
        cell.backgroundColor = .clear
        if indexPath.section == 1 {
            cell.setInfo(with: playerStatisticsGoals[indexPath.row])
        }else if indexPath.section == 2 {
            cell.setInfo(with: playerStatisticsAssistsData[indexPath.row])
        }else if indexPath.section == 3 {
            cell.setInfo(with: playerStatisticsRedCardData[indexPath.row])
        }else if indexPath.section == 4 {
            cell.setInfo(with: playerStatisticsYellowCardData[indexPath.row])
        }else {
            cell.setInfo(with: playerStatisticsGoals[indexPath.row])
        }
        return cell
    }
}

//MARK: - tableView Delegate
extension SectionHeaderDetailPlayerVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let tb = UITableView()
            tb.backgroundColor = .clear
            return tb
        }
        
        let view = SectionFooterTableView()
        view.section = section
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelFooterTapped(_:))))
        if sectionExpanded[section] == false {
            view.setSeeAll(with: "SeeAll")
        }else {
            view.setSeeAll(with: "Close")
        }
        
        return view
    }
    
    @objc private func handelFooterTapped(_ gesterRecognizer: UITapGestureRecognizer) {
        guard let section = (gesterRecognizer.view as? SectionFooterTableView)?.section else { return }
        sectionExpanded[section].toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

//MARK: - setUpViews & setUpConstrains {
extension SectionHeaderDetailPlayerVC{
    func setUpViews(){
        view.addSubview(collectionView)
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    func setUpConstrains(){
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(17)
            make.height.equalTo(50)
//            make.bottom.equalTo(tableView.snp.top).multipliedBy(0.7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(17)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
        }
    }
}




////MARK: - Navigation
//extension SectionHeaderDetailPlayerVC {
//    private func setNav() {
//        createCustomNavigationBar()
//
//        let audioRightButton = createCustomButton(
//            imageName: "phone",
//            selector: #selector(audioRightButtonTapped)
//        )
//        let videoRightButton = createCustomButton(
//            imageName: "video",
//            selector: #selector(videoRightButtonTapped)
//        )
//        let customTitleView = createCustomTitleView(
//            contactName: Database.nameLocationDataArray[0].footballName,
//            contactDescription: Database.nameLocationDataArray[0].location,
//            contactImage: "sdu"
//        )
//
//        navigationItem.rightBarButtonItems = [audioRightButton, videoRightButton]
//        navigationItem.titleView = customTitleView
//    }
//
//    @objc private func audioRightButtonTapped() {
//        print("audioRightButtonTapped")
//    }
//
//    @objc private func videoRightButtonTapped() {
//        print("videoRightButtonTapped")
//    }
//
//}
//
//extension SectionHeaderDetailPlayerVC {
//
//    func createCustomNavigationBar() {
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    }
//
//    func createCustomTitleView(contactName: String, contactDescription: String, contactImage: String) -> UIView {
//
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
//
//        let imageContact = UIImageView()
//        imageContact.image = UIImage(named: contactImage)
//        imageContact.layer.cornerRadius = imageContact.frame.height / 2
//        imageContact.frame = CGRect(x: 5, y: 10, width: 30, height: 20)
//        view.addSubview(imageContact)
//
//        let nameLabel = UILabel()
//        nameLabel.text = contactName
//        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
//        view.addSubview(nameLabel)
//
//        let descriptionLabel = UILabel()
//        descriptionLabel.text = contactDescription
//        descriptionLabel.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
//        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
//        descriptionLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        view.addSubview(descriptionLabel)
//
//        return view
//    }
//
//    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
//
//        let button = UIButton(type: .system)
//        button.setImage(
//            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
//            for: .normal
//        )
//        button.tintColor = .systemBlue
//        button.imageView?.contentMode = .scaleAspectFit
//        button.contentVerticalAlignment = .fill
//        button.contentHorizontalAlignment = .fill
//        button.addTarget(self, action: selector, for: .touchUpInside)
//
//        let menuBarItem = UIBarButtonItem(customView: button)
//        return menuBarItem
//    }
//}

////segment
//
//
//import UIKit
//
//final class SegmentedDailyViewController: UIViewController {
//
//// MARK: - Properties:
//
//    let items = ["details", "graph"]
//
//// MARK: - UI Elements:
//
//    fileprivate var containerView = UIView()
//
//    fileprivate var finReviewViewController = FinReviewDailyViewController()
//    fileprivate var reviewViewController = ReviewDailyViewController()
//
//    fileprivate lazy var segmentControl = UISegmentedControl(items: items).apply {
//        $0.backgroundColor = .mainBlue
//        $0.tintColor = .mainWhite
//
//        $0.selectedSegmentIndex = 0
//
//        $0.addTarget(self, action: #selector(segmentSwap), for: .valueChanged)
//
//        $0.setImage(UIImage(named: "details"), forSegmentAt: 0)
//        $0.setImage(UIImage(named: "graph"), forSegmentAt: 1)
//    }
//
//// MARK: - Lifecycle:
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//    }
//}

//// MARK: - Setup views:
//
//extension SegmentedDailyViewController {
//
//    private func setupViews() {
//        view.backgroundColor = .bgColor
//        view.addSubviews(segmentControl, containerView)
//
//        title = "Fin.review.daily.title".localized
//        finReviewViewController.clickCell = {
//            self.segmentControl.selectedSegmentIndex = 1
//            self.title = "Fin.review.fin.daily.title".localized
//            self.removeChildViewControllers(self.finReviewViewController)
//            self.addChildViewControllers(self.reviewViewController)
//        }
//
//        removeChildViewControllers(reviewViewController)
//        addChildViewControllers(finReviewViewController)
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close_nav_button"),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(dismissClick))
//
//        setupConstraints()
//    }
//
//    private func setupConstraints() {
//        segmentControl.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.left.equalToSuperview().inset(-6)
//            $0.right.equalToSuperview().offset(6)
//            $0.height.equalTo(50)
//        }
//
//        containerView.snp.makeConstraints {
//            $0.top.equalTo(segmentControl.snp.bottom).offset(2)
//            $0.left.right.bottom.equalToSuperview()
//        }
//    }
//}
//
//// MARK: - Methods:
//
//extension SegmentedDailyViewController {
//
//    private func addChildViewControllers(_ viewController: UIViewController) {
//        addChild(viewController)
//
//        containerView.addSubview(viewController.view)
//
//        viewController.view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        viewController.didMove(toParent: self)
//    }
//
//    private func removeChildViewControllers(_ viewController: UIViewController) {
//        viewController.willMove(toParent: nil)
//        viewController.view.removeFromSuperview()
//        viewController.removeFromParent()
//    }
//}
//
//// MARK: - Action:
//
//extension SegmentedDailyViewController {
//
//    @objc func segmentSwap(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            title = "Fin.review.daily.title".localized
//            removeChildViewControllers(reviewViewController)
//            addChildViewControllers(finReviewViewController)
//        case 1:
//            title = "Fin.review.fin.daily.title".localized
//            removeChildViewControllers(finReviewViewController)
//            addChildViewControllers(reviewViewController)
//        default:
//            break
//        }
//    }
//}




/*
 
 
 
 
 //
 //  SectionHeaderDetailPlayerVC.swift
 //  LiveScore SDU
 //
 //  Created by Aruzhan Boranbay on 16.03.2023.
 //

 import UIKit
 import SnapKit

 class SectionHeaderDetailPlayerVC: UIViewController {
     let apiCaller = APICaller()
     
     var id: Int
     
     init(id: Int) {
         self.id = id
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     let refreshControl = UIRefreshControl()
     
     var allList: [[PlayerStatisticsDatum]] = []
     
     private var playerStatisticsGoals: [PlayerStatisticsDatum] = []
     private var playerStatisticsAssistsData: [PlayerStatisticsDatum] = []
     private var playerStatisticsRedCardData: [PlayerStatisticsDatum] = []
     private var playerStatisticsYellowCardData: [PlayerStatisticsDatum] = []
     
     private lazy var array = ["ALL", "GOALS SCORED", "ASSISTS", "RED CARD", "YELLOW CARD"]
     
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
         tableView.register(SectionHeaderPlayerTableViewCell.self, forCellReuseIdentifier: SectionHeaderPlayerTableViewCell.IDENTIFIER)
         tableView.allowsSelection = false
         tableView.showsVerticalScrollIndicator = false
         tableView.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
         tableView.layer.borderWidth = 1
         tableView.layer.cornerRadius = 10
         return tableView
     }()
  
     override func viewDidLoad() {
         super.viewDidLoad()
         
         refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
         refreshControl.tintColor = .orange
 //        view.backgroundColor = .systemPink
         
         collectionView.dataSource = self
         collectionView.delegate = self
         
         selectedCategory = array[0]
         
         tableView.dataSource = self
         
         //connect with backpart
         allFetchAPI()
         
         //want see all list
         print(allList)

         setUpViews()
         setUpConstrains()
         
     }
     
     @objc private func refreshTable() {
         tableView.reloadData()
         refreshControl.endRefreshing()
     }
     
     //for show the datas which you choose in collection cell
     var selectedCollectionIndex: Int = 0
     var selectedCategory: String = ""
     
     //MARK: - Connect with BACK
     func allFetchAPI(){
         
         apiCaller.fetchRequestPS (completion: { [weak self] values in
             DispatchQueue.main.async {
                 guard let self else { return }
                 self.playerStatisticsGoals = values
                 self.tableView.reloadData()
             }
         }, sectionName: APIStats.goals.rawValue, tournamentId: id)
         
         apiCaller.fetchRequestPS (completion: { [weak self] values in
             DispatchQueue.main.async {
                 guard let self else { return }
                 self.playerStatisticsAssistsData = values
                 self.tableView.reloadData()
             }
         }, sectionName: APIStats.assist.rawValue, tournamentId: id)
         
         apiCaller.fetchRequestPS (completion: { [weak self] values in
             DispatchQueue.main.async {
                 guard let self else { return }
                 self.playerStatisticsRedCardData = values
                 self.tableView.reloadData()
             }
         }, sectionName: APIStats.redCard.rawValue, tournamentId: id)
         
         apiCaller.fetchRequestPS (completion: { [weak self] values in
             DispatchQueue.main.async {
                 guard let self else { return }
                 self.playerStatisticsYellowCardData = values
                 self.tableView.reloadData()
             }
         }, sectionName: APIStats.yellowCard.rawValue, tournamentId: id)
         
     }
     
     @objc func changeView(_ : UIButton) -> UIView {
 //        let btnArray: [UIButton] = [btnTeam, btnTable, btnPlayer, btnMatches, btnOverview]
         
 //        for button in btnArray {
 //            print("\(button) clicked")
 //            switchChangeButton(button)
         var button = UIButton()
 //        switch button {
 //                case btnOverview:
 //                    mainView.backgroundColor = .blue
 //                    print("overview")
 //                case btnMatches:
 //                    mainView.backgroundColor = .orange
 //                    print("btnMatches")
 //                case btnTeam:
 //                    mainView.backgroundColor = .yellow
 //                    print("btnTeam")
 //                case btnTable:
 //                    mainView.backgroundColor = .systemPink
 //                    print("btnTable")
 //                case btnPlayer:
 //                    mainView.backgroundColor = .gray
 //                    print("btnPlayer")
 //                default:
 //                    break
 //                }
 //        }
         return view
     }
     
 //    @objc func switchChangeButton(_ buttoon: UIButton) {
 //        switch buttoon {
 //        case btnOverview:
 //            btnOverview.addTarget(self, action: #selector(switchChangeButton(_:)), for: .touchUpInside)
 //            let vc = FavoritesViewController()
 //            navigationController?.present(vc, animated: true)
 //            print("helllo")
 //        case btnMatches:
 //            let vc = RefreshViewController()
 //            navigationController?.present(vc, animated: true)
 //        case btnTeam:
 //            let vc = ScoresViewController()
 //            navigationController?.present(vc, animated: true)
 //        case btnTable:
 //            let vc = FavoritesViewController()
 //            navigationController?.present(vc, animated: true)
 //        case btnPlayer:
 //            let vc = FavoritesViewController()
 //            navigationController?.present(vc, animated: true)
 //        default:
 //            break
 //        }
 //    }
     
 //    //MARK: - creat button func
 //    func createButton(name: String, titleColor: UIColor) -> UIButton {
 //        let button = UIButton(type: .system)
 //        button.setTitle("\(name)", for: .normal)
 //        button.setTitleColor(titleColor, for: .normal)
 //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
 //        button.setTitleColor(UIColor.orange, for: UIControl.State.focused)
 //        button.addTarget(self, action: #selector(changeView(_:)), for: .touchUpInside)
 //
 //        return button
 //    }

 }

 //MARK: - API Delegate
 extension SectionHeaderDetailPlayerVC: AllPlayStatsData {
     func didFetch(with: [PlayerStatisticsDatum]) {
         allList.append(with)
         print(allList)
         
         DispatchQueue.main.async {
             self.tableView.reloadData()
         }
     }
     
 }

 //MARK: - collectionView DataSource
 extension SectionHeaderDetailPlayerVC: UICollectionViewDataSource{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return array.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionHeaderStatsCollectionViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderStatsCollectionViewCell
         cell.configure(with: array[indexPath.item])
         cell.layer.cornerRadius = 13
         cell.layer.borderWidth = 1
         cell.layer.borderColor = CGColor.init(red: 58, green: 58, blue: 58, alpha: 1)
 //        cell.backgroundColor = .clear
         if array[indexPath.row] == selectedCategory {
             cell.backgroundColor = .gray
         }else {
             cell.backgroundColor = .clear
         }
         return cell
     }

 }

 //MARK: - CollectionView Delegate
 extension SectionHeaderDetailPlayerVC: UICollectionViewDelegate{
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         selectedCollectionIndex = indexPath.row
         selectedCategory = array[indexPath.row]
         
         collectionView.reloadData()
         tableView.reloadData()
     }
 }

 //MARK: - CollectionView Delegate: Cell Layout Size
 extension SectionHeaderDetailPlayerVC: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let label = UILabel()
         label.text = array[indexPath.row]
         label.sizeToFit()
         return CGSize(width: label.frame.size.width + 3, height: collectionView.frame.size.height - 25)
     }
 }

 //MARK: - TableView DataSource
 extension SectionHeaderDetailPlayerVC: UITableViewDataSource {
     //section
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         if selectedCollectionIndex != 0 {
             return array[selectedCollectionIndex]
         }
         return array[section]
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
         if selectedCollectionIndex != 0{
             return 1
         }
         return array.count
     }
     
     //cell
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         /*
          ["ALL", "GOALS SCORED", "ASSISTS", "RED CARD", "YELLOW CARD"]
          */
         if selectedCollectionIndex != 0 {
             if selectedCollectionIndex == 1 {
                 return playerStatisticsGoals.count
             }else if selectedCollectionIndex == 2 {
                 return playerStatisticsAssistsData.count
             }else if selectedCollectionIndex == 3 {
                 return playerStatisticsRedCardData.count
             }else if selectedCollectionIndex == 4 {
                 return playerStatisticsYellowCardData.count
             }
         }else {
             if section == 1 {
                 return playerStatisticsGoals.count
             }else if section == 2 {
                 return playerStatisticsAssistsData.count
             }else if section == 3 {
                 return playerStatisticsRedCardData.count
             }else if section == 4 {
                 return playerStatisticsYellowCardData.count
             }
         }
         return 0
         
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderPlayerTableViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderPlayerTableViewCell
         cell.backgroundColor = .clear
         if indexPath.section == 1 {
             cell.setInfo(with: playerStatisticsGoals[indexPath.row])
         }else if indexPath.section == 2 {
             cell.setInfo(with: playerStatisticsAssistsData[indexPath.row])
         }else if indexPath.section == 3 {
             cell.setInfo(with: playerStatisticsRedCardData[indexPath.row])
         }else if indexPath.section == 4 {
             cell.setInfo(with: playerStatisticsYellowCardData[indexPath.row])
         }else {
             cell.setInfo(with: playerStatisticsGoals[indexPath.row])
         }
         return cell
     }
 }

 //MARK: - setUpViews & setUpConstrains {
 extension SectionHeaderDetailPlayerVC{
     func setUpViews(){
         view.addSubview(collectionView)
         view.addSubview(tableView)
         tableView.addSubview(refreshControl)
     }
     
     func setUpConstrains(){
         collectionView.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.leading.trailing.equalToSuperview().inset(17)
             make.height.equalTo(50)
 //            make.bottom.equalTo(tableView.snp.top).multipliedBy(0.7)
         }
         
         tableView.snp.makeConstraints { make in
             make.top.equalTo(collectionView.snp.bottom)
             make.leading.trailing.equalToSuperview().inset(17)
             make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.9)
         }
     }
 }




 ////MARK: - Navigation
 //extension SectionHeaderDetailPlayerVC {
 //    private func setNav() {
 //        createCustomNavigationBar()
 //
 //        let audioRightButton = createCustomButton(
 //            imageName: "phone",
 //            selector: #selector(audioRightButtonTapped)
 //        )
 //        let videoRightButton = createCustomButton(
 //            imageName: "video",
 //            selector: #selector(videoRightButtonTapped)
 //        )
 //        let customTitleView = createCustomTitleView(
 //            contactName: Database.nameLocationDataArray[0].footballName,
 //            contactDescription: Database.nameLocationDataArray[0].location,
 //            contactImage: "sdu"
 //        )
 //
 //        navigationItem.rightBarButtonItems = [audioRightButton, videoRightButton]
 //        navigationItem.titleView = customTitleView
 //    }
 //
 //    @objc private func audioRightButtonTapped() {
 //        print("audioRightButtonTapped")
 //    }
 //
 //    @objc private func videoRightButtonTapped() {
 //        print("videoRightButtonTapped")
 //    }
 //
 //}
 //
 //extension SectionHeaderDetailPlayerVC {
 //
 //    func createCustomNavigationBar() {
 //        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
 //    }
 //
 //    func createCustomTitleView(contactName: String, contactDescription: String, contactImage: String) -> UIView {
 //
 //        let view = UIView()
 //        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
 //
 //        let imageContact = UIImageView()
 //        imageContact.image = UIImage(named: contactImage)
 //        imageContact.layer.cornerRadius = imageContact.frame.height / 2
 //        imageContact.frame = CGRect(x: 5, y: 10, width: 30, height: 20)
 //        view.addSubview(imageContact)
 //
 //        let nameLabel = UILabel()
 //        nameLabel.text = contactName
 //        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
 //        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
 //        view.addSubview(nameLabel)
 //
 //        let descriptionLabel = UILabel()
 //        descriptionLabel.text = contactDescription
 //        descriptionLabel.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
 //        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
 //        descriptionLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
 //        view.addSubview(descriptionLabel)
 //
 //        return view
 //    }
 //
 //    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
 //
 //        let button = UIButton(type: .system)
 //        button.setImage(
 //            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
 //            for: .normal
 //        )
 //        button.tintColor = .systemBlue
 //        button.imageView?.contentMode = .scaleAspectFit
 //        button.contentVerticalAlignment = .fill
 //        button.contentHorizontalAlignment = .fill
 //        button.addTarget(self, action: selector, for: .touchUpInside)
 //
 //        let menuBarItem = UIBarButtonItem(customView: button)
 //        return menuBarItem
 //    }
 //}

 ////segment
 //
 //
 //import UIKit
 //
 //final class SegmentedDailyViewController: UIViewController {
 //
 //// MARK: - Properties:
 //
 //    let items = ["details", "graph"]
 //
 //// MARK: - UI Elements:
 //
 //    fileprivate var containerView = UIView()
 //
 //    fileprivate var finReviewViewController = FinReviewDailyViewController()
 //    fileprivate var reviewViewController = ReviewDailyViewController()
 //
 //    fileprivate lazy var segmentControl = UISegmentedControl(items: items).apply {
 //        $0.backgroundColor = .mainBlue
 //        $0.tintColor = .mainWhite
 //
 //        $0.selectedSegmentIndex = 0
 //
 //        $0.addTarget(self, action: #selector(segmentSwap), for: .valueChanged)
 //
 //        $0.setImage(UIImage(named: "details"), forSegmentAt: 0)
 //        $0.setImage(UIImage(named: "graph"), forSegmentAt: 1)
 //    }
 //
 //// MARK: - Lifecycle:
 //
 //    override func viewDidLoad() {
 //        super.viewDidLoad()
 //        setupViews()
 //    }
 //}

 //// MARK: - Setup views:
 //
 //extension SegmentedDailyViewController {
 //
 //    private func setupViews() {
 //        view.backgroundColor = .bgColor
 //        view.addSubviews(segmentControl, containerView)
 //
 //        title = "Fin.review.daily.title".localized
 //        finReviewViewController.clickCell = {
 //            self.segmentControl.selectedSegmentIndex = 1
 //            self.title = "Fin.review.fin.daily.title".localized
 //            self.removeChildViewControllers(self.finReviewViewController)
 //            self.addChildViewControllers(self.reviewViewController)
 //        }
 //
 //        removeChildViewControllers(reviewViewController)
 //        addChildViewControllers(finReviewViewController)
 //
 //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close_nav_button"),
 //                                                            style: .plain,
 //                                                            target: self,
 //                                                            action: #selector(dismissClick))
 //
 //        setupConstraints()
 //    }
 //
 //    private func setupConstraints() {
 //        segmentControl.snp.makeConstraints {
 //            $0.top.equalToSuperview()
 //            $0.left.equalToSuperview().inset(-6)
 //            $0.right.equalToSuperview().offset(6)
 //            $0.height.equalTo(50)
 //        }
 //
 //        containerView.snp.makeConstraints {
 //            $0.top.equalTo(segmentControl.snp.bottom).offset(2)
 //            $0.left.right.bottom.equalToSuperview()
 //        }
 //    }
 //}
 //
 //// MARK: - Methods:
 //
 //extension SegmentedDailyViewController {
 //
 //    private func addChildViewControllers(_ viewController: UIViewController) {
 //        addChild(viewController)
 //
 //        containerView.addSubview(viewController.view)
 //
 //        viewController.view.snp.makeConstraints {
 //            $0.edges.equalToSuperview()
 //        }
 //
 //        viewController.didMove(toParent: self)
 //    }
 //
 //    private func removeChildViewControllers(_ viewController: UIViewController) {
 //        viewController.willMove(toParent: nil)
 //        viewController.view.removeFromSuperview()
 //        viewController.removeFromParent()
 //    }
 //}
 //
 //// MARK: - Action:
 //
 //extension SegmentedDailyViewController {
 //
 //    @objc func segmentSwap(_ sender: UISegmentedControl) {
 //        switch sender.selectedSegmentIndex {
 //        case 0:
 //            title = "Fin.review.daily.title".localized
 //            removeChildViewControllers(reviewViewController)
 //            addChildViewControllers(finReviewViewController)
 //        case 1:
 //            title = "Fin.review.fin.daily.title".localized
 //            removeChildViewControllers(finReviewViewController)
 //            addChildViewControllers(reviewViewController)
 //        default:
 //            break
 //        }
 //    }
 //}

 
 
 
 
 
 */
