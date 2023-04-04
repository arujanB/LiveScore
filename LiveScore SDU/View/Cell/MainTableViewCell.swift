//
//  MyTableViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 28.02.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let IDENTIFIER = "MainTableViewCell"

    var scoreEnum: ScoreSegment = .today
    var mainGameDataFromScore: [MainGameDatum] = []
    var mainGameDataFromScoreScreen: [MainGameDatum] = []
    var selectedCategoryScreen = ""
    
    var outputDetail: ((Int) -> Void)?
    
    private lazy var mainCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.IDENTIFIER)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.layer.borderColor = .init(genericGrayGamma2_2Gray: 1, alpha: 1)
//        collectionView.isScrollEnabled = false

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("OTHER VC CELL\(mainGameDataFromScore)")
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload() {
        mainCollectionView.reloadData()
    }
}

//MARK: - CollectionView DataSource
extension MainTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return mainGameDataFromScore.count
        return mainGameDataFromScoreScreen.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.IDENTIFIER, for: indexPath) as! MainCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderColor = .init(red: 0.104, green: 0.104, blue: 0.104, alpha: 1)
        cell.layer.borderWidth = 1
        print("Main TableView cell\(mainGameDataFromScore)")
        print("Main TableView cell\(mainGameDataFromScoreScreen)")
        
        cell.configure(with: mainGameDataFromScoreScreen[indexPath.row])
        cell.backgroundColor = .gray
        cell.outputDetail = {
            self.outputDetail?(indexPath.row)
        }
//        let indexPath = IndexPath(item: mainGameDataFromScoreScreen[indexPath.row].protocolID, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
        
        return cell
    }
    
}

extension MainTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        outputDetail?(indexPath.row)
    }

}

//MARK: - CollectionView Delegate CellLayoutSize
extension MainTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 10, height: 70)
    }
}

//MARK: - setUpViews & setUpConstrains
extension MainTableViewCell{
    func setUpViews() {
        contentView.addSubview(mainCollectionView)
    }
    
    func setUpConstraints(){
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
