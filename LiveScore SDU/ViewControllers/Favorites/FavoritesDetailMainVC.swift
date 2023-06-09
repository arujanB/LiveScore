//
//  FavoriteDetailViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 20.04.2023.
//

import UIKit

class FavoritesDetailMainVC: UIViewController {

    let apiCaller = APICaller()
    var favoritesData: FavoritesDatum?
    
    init(model: FavoritesDatum) {
        self.favoritesData = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    private lazy var tableVC = FavoritesTableVC(id: favoritesData?.groupID ?? 0)
    private lazy var playerVC = SectionHeaderDetailPlayerVC(id: favoritesData?.groupID ?? 0)
    private lazy var teamVC = SectionHeaderDetailTeamVC(id: favoritesData?.groupID ?? 0)

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
        segmentControlValuChanged(segmentControll)
        tableVC.load()
                
        setUpViews()
        setUpConstrains()
       
    }

}

//MARK: - setUpViews & setUpConstrains
extension FavoritesDetailMainVC {
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
        }
    }
}
