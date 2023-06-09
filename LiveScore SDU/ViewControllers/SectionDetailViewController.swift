//
//  SectionDetailViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 09.03.2023.
//

import UIKit

class SectionDetailViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemPink
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var tableView:UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(TablePlayersTableViewCell.self, forCellReuseIdentifier: TablePlayersTableViewCell.IDENTIFIER)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        setNav()
        
        setUpViews()
        setUpConstrains()
        
        tableView.dataSource = self
//        tableView.delegate = self
    }
    
}

extension SectionDetailViewController: UICollectionViewDelegateFlowLayout{
    
}

//MARK: - TableView Data Source
extension SectionDetailViewController: UITableViewDataSource{
    //section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "team"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.playerInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TablePlayersTableViewCell.IDENTIFIER, for: indexPath) as! TablePlayersTableViewCell
        cell.backgroundColor = .clear
        cell.setInfo(with: Database.playerInfoArray[indexPath.row])
        return cell
    }
    
    
}

//MARK: - setUpViews & setUpConstrains
extension SectionDetailViewController {
    func setUpViews() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func setUpConstrains() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().inset(30)
        }
    }
}


//MARK: - Navigation
extension SectionDetailViewController {
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
        let customTitleView = createCustomTitleView(
            contactName: Database.nameLocationDataArray[0].logo,
            contactDescription: "Almaty",
            contactImage: "swift"
        )
        
        navigationItem.rightBarButtonItems = [audioRightButton, videoRightButton]
        navigationItem.titleView = customTitleView
    }
    
    @objc private func audioRightButtonTapped() {
        print("audioRightButtonTapped")
    }
    
    @objc private func videoRightButtonTapped() {
        print("videoRightButtonTapped")
    }

}

extension SectionDetailViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func createCustomTitleView(contactName: String, contactDescription: String, contactImage: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        
        let imageContact = UIImageView()
        imageContact.image = UIImage(named: contactImage)
        imageContact.layer.cornerRadius = imageContact.frame.height / 2
        imageContact.frame = CGRect(x: 5, y: 0, width: 40, height: 40)
        view.addSubview(imageContact)
        
        let nameLabel = UILabel()
        nameLabel.text = contactName
        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(nameLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = contactDescription
        descriptionLabel.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.addSubview(descriptionLabel)
        
        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.tintColor = .systemBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
