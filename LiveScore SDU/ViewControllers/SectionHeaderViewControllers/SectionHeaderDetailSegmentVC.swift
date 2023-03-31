//
//  SectionHeaderDetailSegmentVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 24.03.2023.
//

import UIKit
import SnapKit

class SectionHeaderDetailSegmentVC: UIViewController {
    
    private lazy var containerView = UIView()
    
    private lazy var segmentControll: UISegmentedControl = {
        var segmentControll = UISegmentedControl(items: [DetailSegment.button.rawValue, DetailSegment.matches.rawValue, DetailSegment.table.rawValue, DetailSegment.stat.rawValue, DetailSegment.last.rawValue])
        segmentControll.selectedSegmentIndex = 2
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: UIControl.State.selected)
//        segmentControll.addTarget(self, action: #selector(segmentControlValuChanged(_:)), for: .valueChanged)
        segmentControll.removeBorders()
        return segmentControll
    }()
    
    private lazy var line: UIView = {
        var view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private var tableVC = SectionHeaderDetailMainVC()
    private var playerVC = SectionHeaderDetailPlayerVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstrains()
        
    }
    
    @objc func segmentControlValuChanged(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            removeChildViewControllers(playerVC)
            addChildViewControllers(tableVC)
        }else {
            removeChildViewControllers(tableVC)
            addChildViewControllers(playerVC)
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

}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderDetailSegmentVC{
    func setUpViews(){
        view.addSubview(segmentControll)
        view.addSubview(containerView)
    }
    
    func setUpConstrains(){
        segmentControll.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(segmentControll.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
