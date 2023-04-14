//
//  Page2ViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 12.04.2023.
//

import UIKit
import SnapKit

class Page2ViewController: UIViewController/*, PageProtocol*/ {
    var pageIndex: Int = 1

    let apiCaller = APICaller()
    var tournamentData: [WelcomeDatum] = []
    
    private lazy var myLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Follow\nTournaments"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private let myTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.IDENTIFIER)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var myButton: UIButton = {
        var button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .orange
        button.tintColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var ceo: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "©2023 Arsensio_20"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myButton.addTarget(self, action: #selector(handleTapGesture(_:)), for: .touchUpInside)
        
        apiCaller.fetchRequestWelcome(completion: { values in
            DispatchQueue.main.async {
                self.tournamentData = values
                self.myTableView.reloadData()
            }
        })
        
        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        searchBar.delegate = self
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        setUpViews()
        setUpConstrains()
    }
    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let moveVC = Page3ViewController()
        navigationController?.pushViewController(moveVC, animated: true)
    }

}

//MARK: - SearchBar delegate
extension Page2ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()                       //drop the searchbatton after you pressing enter
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {// help search automatically when you write
        let query = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        print(query ?? "")
    }
}

//MARK: - TableView DataSource
extension Page2ViewController: UITableViewDataSource{
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournamentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.IDENTIFIER, for: indexPath) as! FavoritesTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        cell.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        cell.setWelcome2Page(with: tournamentData[indexPath.row])
        
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
extension Page2ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}

//MARK: - setUpViews & setUpConstrains
extension Page2ViewController{
    func setUpViews(){
        view.addSubview(myLabel)
        view.addSubview(searchBar)
        view.addSubview(myTableView)
        view.addSubview(myButton)
        view.addSubview(ceo)
    }
    
    func setUpConstrains(){
        myLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().inset(10)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(myLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(7)
            make.height.equalTo(330)
        }
        
        myButton.snp.makeConstraints { make in
            make.top.equalTo(myTableView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(7)
        }
        
        ceo.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(7)
        }
    }
}

