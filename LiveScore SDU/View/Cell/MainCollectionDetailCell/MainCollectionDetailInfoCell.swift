//
//  MainCollectionDetailInfoCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 02.04.2023.
//

import UIKit

class MainCollectionDetailInfoCell: UITableViewCell {
    static let IDENTIFIER = "MainCollectionDetailInfoCell"
    
    var eventsData: [Event] = []
    
//    var mainDataCellDataTeam: MainCellData?
    
    var teamId1 = 0
    var teamId2 = 0
    
    private lazy var numberLabel: UILabel = myLabel(with: "5+2")
    
    private lazy var score: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10.5)
        label.text = "1 - 0"
        label.textColor = .white
        return label
    }()
    private lazy var name1Group: UILabel = myLabel2(with: "Luccas Tarro")
    private lazy var assist1Group: UILabel = myLabel2(with: "")
    private lazy var name2Group: UILabel = myLabel2(with: "Default")
    private lazy var assist2Group: UILabel = myLabel2(with: "")
    
    private lazy var stackViewAssist1: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(name1Group)
        stackView.addArrangedSubview(assist1Group)

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var stackViewAssist2: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(name2Group)
        stackView.addArrangedSubview(assist2Group)

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    private lazy var img1Group: UIImageView = myImg(with: " ")
    private lazy var img2Group: UIImageView = myImg(with: " ")

    private lazy var stackViewMainName: UIStackView = {
        var stackView = UIStackView()
//        stackView.addArrangedSubview(name1Group)
        stackView.addArrangedSubview(stackViewAssist1)
        stackView.addArrangedSubview(img1Group)
        stackView.addArrangedSubview(score)
        stackView.addArrangedSubview(img2Group)
//        stackView.addArrangedSubview(name2Group)
        stackView.addArrangedSubview(stackViewAssist2)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()

    private lazy var stackViewMainMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(stackViewMainName)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        setUpViews()
        setUpConstrains()
        
//        print(mainDataCellDataTeam)
//        teamId1
//        teamId2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func myLabel(with value: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.5)
        label.text = value
        label.textColor = .white
        return label
    }
    
    func myLabel2(with value: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.5)
        label.text = value
        label.textColor = .white
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return label
    }
    
    func myImg(with named: String) -> UIImageView {
        let img = UIImageView()
        img.image = UIImage(named: named)
        img.sizeThatFits(CGSize.init(width: 5, height: 5))

        img.layer.cornerRadius = 10 //it works with maskToBounds /*do not forget it to use*/
        img.layer.masksToBounds = true

        return img
    }
    
//    func setInfo(with data: PlayerStatisticsDatum){
////        self.id.text = "\(data.perGame)"
//        self.name1Group.text = "\(data.playerName)"
//        self.numberLabel.text = "\(data.total)"
//        
//        let url = URL(string: data.teamLogo)!
//        img1Group.kf.setImage(with: url)
//    }
    
    func configure(with events: Event, with mainCell: MainCellData) {
        numberLabel.text = "\(events.minute)"
        score.text = events.gameScore
        
        if mainCell.team1Id == events.teamId{
            name1Group.text = events.playerName
            name2Group.text = " "
            
            if events.eventName == "GOAL"{
                img1Group.image = UIImage(named: "ball")
            }else if events.eventName == "YELLOW_CARD"{
                img1Group.image = UIImage(named: "yellowCard")
            }else {
                img1Group.image = UIImage(named: "redCard")
            }
            
            if events.assist != nil {
                assist1Group.text = events.assist?.assistPlayer
            }
        }
        
        if mainCell.team2Id == events.teamId {
            name1Group.text = " "
            name2Group.text = events.playerName
            
            if events.eventName == "GOAL"{
                img2Group.image = UIImage(named: "ball")
            }else if events.eventName == "YELLOW_CARD"{
                img2Group.image = UIImage(named: "yellowCard")
            }else {
                img2Group.image = UIImage(named: "redCard")
            }
            
            if events.assist != nil {
                assist2Group.text = events.assist?.assistPlayer
            }
        }
    }
    
}

    //MARK: - setUpViews & setUpConstrains
extension MainCollectionDetailInfoCell {
    func setUpViews() {
        contentView.addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        img1Group.snp.makeConstraints { make in
            make.size.equalTo(13)
        }
        
        img2Group.snp.makeConstraints { make in
            make.size.equalTo(13)
        }
    }
}
