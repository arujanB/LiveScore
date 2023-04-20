//
//  FavoritesViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 04.03.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let apiCaller = APICaller()
    var items: [WelcomeDatumItem] = []
    var favoritesSectionData: [FavoritesDatum] = []
    
    private lazy var myLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "FAVORITES"
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
        tableView.register(Welcome2PageTableViewCell.self, forCellReuseIdentifier: Welcome2PageTableViewCell.IDENTIFIER)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        searchBar.delegate = self
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        setUpViews()
        setUpConstrains()
        
        loadItems()
    }
    
    private func loadItems() {
        var favorites: [WelcomeDatumItem] = []
        
        if let data = UserDefaults.standard.value(forKey: "favorites") as? Data {
            favorites = try! PropertyListDecoder().decode([WelcomeDatumItem].self, from: data)
        }
         items = favorites
    }

}


//MARK: - SearchBar delegate
extension FavoritesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()                       //drop the searchbatton after you pressing enter
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {// help search automatically when you write
        let query = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        print(query ?? "")
    }
}

//MARK: - TableView DataSource
extension FavoritesViewController: UITableViewDataSource{
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Welcome2PageTableViewCell.IDENTIFIER, for: indexPath) as! Welcome2PageTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        cell.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        
        cell.setWelcome2Page(with: items[indexPath.row])
        cell.delegate = self
        
        cell.outputDetail = { [weak self] tournament in
            guard let self else { return }
            
            self.apiCaller.fetchRequestFavoritesSection (completion: { [weak self] values in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.favoritesSectionData = values
                    self.myTableView.reloadData()
                }
            },  tourId: tournament)
            
            let vc = ScoresViewController()
//            vc.dataTakeForTabHeader = data
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
extension FavoritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}

//MARK: - setUpViews & setUpConstrains
extension FavoritesViewController{
    func setUpViews(){
        view.addSubview(myLabel)
        view.addSubview(searchBar)
        view.addSubview(myTableView)
    }
    
    func setUpConstrains(){
        myLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(myLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(7)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension FavoritesViewController: Welcome2PageTableViewCellDelegate {
    func welcome2PageTableViewCell(_ welcome2PageTableViewCell: Welcome2PageTableViewCell, didFavorite item: WelcomeDatumItem) {
        let item = WelcomeDatumItem(welcomeDatum: item.welcomeDatum, isFavorite: !item.isFavorite)
        
        var favorites: [WelcomeDatumItem] = []
        
        if let data = UserDefaults.standard.value(forKey: "favorites") as? Data {
            favorites = try! PropertyListDecoder().decode([WelcomeDatumItem].self, from: data)
        }
        
        if let index = favorites.firstIndex(where: { $0.welcomeDatum.tournamentID == item.welcomeDatum.tournamentID }) {
            if item.isFavorite == false {
                favorites.remove(at: index)
            }
        } else {
            favorites.append(item)
        }
        
        if let data = try? PropertyListEncoder().encode(favorites){
            UserDefaults.standard.set(data, forKey: "favorites")
        }
        
        items = favorites
        
        myTableView.reloadData()
        
    }
    
}
