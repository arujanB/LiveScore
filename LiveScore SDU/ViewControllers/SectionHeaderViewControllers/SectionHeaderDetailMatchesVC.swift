//
//  SectionHeaderDetailMatchesVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 26.03.2023.
//

import UIKit
import SnapKit

class SectionHeaderDetailMatchesVC: UIViewController {
    
    private var arrayEx: [String] = ["TODAY", "THUESDAY"]

    //MARK: - TableView
    private let myTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(SectionHeaderDetailMatchesViewCell.self, forCellReuseIdentifier: SectionHeaderDetailMatchesViewCell.IDENTIFIER)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .orange
        setUpViews()
        setUpConstrains()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
 
}

//MARK: - TableView DataSource
extension SectionHeaderDetailMatchesVC: UITableViewDataSource{
    //section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayEx[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayEx.count
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderDetailMatchesViewCell.IDENTIFIER, for: indexPath) as! SectionHeaderDetailMatchesViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        cell.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        
        cell.outputDetail = {
            let vc = MainCollectionDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    //give SPACE between the CELL in uitableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1).cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}

//MARK: - TableView Delegate
extension SectionHeaderDetailMatchesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderDetailMatchesVC{
    func setUpViews(){
        view.addSubview(myTableView)
    }
    
    func setUpConstrains(){
        myTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(7)
        }
    }
}
