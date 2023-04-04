//
//  MainCollectionDetailGoalCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 01.04.2023.
//

import UIKit
import SnapKit

class MainCollectionDetailGoalCell: UITableViewCell {
    static let IDENTIFIER = "MainCollectionDetailGoalCell"
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        label.text = "name"
        return label
    }()
    
    private lazy var goalScore: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
//        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        label.text = "48+3"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(goalScore)
        
        stackView.axis = .horizontal
//        stackView.alignment = .leading
//        stackView.distribution = .equalCentering
        stackView.spacing = 3
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        
        setUpViews()
        setUpConstains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure1(with events: Event, with mainCell: MainCellData) {
        if mainCell.team1Id == events.teamId{
            name.text = events.playerName

            if events.eventName == "GOAL"{
                goalScore.text = "\(events.minute)"
            }
        }
    }
    
    func configure2(with events: Event, with mainCell: MainCellData) {
        if mainCell.team2Id == events.teamId{
            name.text = events.playerName

            if events.eventName == "GOAL"{
                goalScore.text = "\(events.minute)"
            }
        }
    }

    
}
//MARK: - SetUpViews & setUpConstrains
extension MainCollectionDetailGoalCell {
    func setUpViews() {
        contentView.addSubview(stackView)
    }
    
    func setUpConstains() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}
