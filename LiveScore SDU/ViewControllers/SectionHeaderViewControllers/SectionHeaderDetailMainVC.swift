//
//  SectionDetailViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 09.03.2023.
//

import UIKit

class SectionHeaderDetailMainVC: UIViewController {
    let apiCaller = APICaller()
    var mainGameDataChangeNewData: MainGameDataChangeNewDatum?
    
    init(model: MainGameDataChangeNewDatum) {
        self.mainGameDataChangeNewData = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let sectionHV = ScoresViewController()
    
    private lazy var line: UIView = {
        var view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    //MARK: - SEGMENT
    private lazy var containerView = UIView()
    
    private lazy var segmentControll: UISegmentedControl = {
        var segmentControll = UISegmentedControl(items: [DetailSegment.button.rawValue, DetailSegment.matches.rawValue, DetailSegment.table.rawValue, DetailSegment.stat.rawValue, DetailSegment.last.rawValue])
        segmentControll.selectedSegmentIndex = 2
        segmentControll.addTarget(self, action: #selector(segmentControlValuChanged(_:)), for: .valueChanged)
        
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
    private var tableVC = SectionHeaderDetailTableVC()
    private lazy var playerVC = SectionHeaderDetailPlayerVC(id: mainGameDataChangeNewData?.tournamentId ?? 0)
    private lazy var teamVC = SectionHeaderDetailTeamVC(id: mainGameDataChangeNewData?.tournamentId ?? 0)

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
//        sectionHV.delegate = self
//        sectionHV.fetchData()

        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        setNav()
        
        setUpViews()
        setUpConstrains()
    }
    
}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderDetailMainVC {
    func setUpViews() {
        view.addSubview(line)
        view.addSubview(segmentControll)
        view.addSubview(containerView)
    }
    
    func setUpConstrains() {
        segmentControll.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(7)
            make.height.equalTo(50)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(segmentControll.snp.bottom).inset(5)
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

//MARK: - Navigation
extension SectionHeaderDetailMainVC {
    private func setNav() {
        guard let datatake = mainGameDataChangeNewData else { return }
        
        let customTitleView = createCustomTitleView(contactName: datatake.tournamentName,
                                                    contactDescribtion: datatake.groupName,
                                                    contactImg: datatake.tournamentLogo)
        
        navigationItem.titleView = customTitleView
    }

    func createCustomTitleView(contactName: String, contactDescribtion: String, contactImg: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        
        let imageContact = UIImageView()
        let url = URL(string: contactImg)!
        imageContact.kf.setImage(with: url)
        //imageContact.image = contactImg
        imageContact.layer.cornerRadius = imageContact.frame.height / 2
        imageContact.frame = CGRect(x: 5, y: 10, width: 30, height: 20)
        view.addSubview(imageContact)
        
        let nameLabel = UILabel()
        nameLabel.text = contactName
        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(nameLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = contactDescribtion
        descriptionLabel.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        descriptionLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.addSubview(descriptionLabel)
        
        return view
    }
}
