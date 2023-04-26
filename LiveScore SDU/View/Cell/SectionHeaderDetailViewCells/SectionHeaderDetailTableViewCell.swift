//
//  TablePlayersTableViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 09.03.2023.
//

import UIKit
import Kingfisher

class SectionHeaderDetailTableViewCell: UITableViewCell {

    static let IDENTIFIER = "SectionHeaderDetailTableViewCell"
    
    private lazy var id: UILabel = myLabel(with: "1")
    private lazy var name: UILabel = myLabel(with: "Default")
    
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "barsa")
        img.sizeThatFits(CGSize.init(width: 5, height: 5))
            
        img.layer.cornerRadius = 10 //it works with maskToBounds /*do not forget it to use*/
        img.layer.masksToBounds = true
                
        return img
    }()
    
    private lazy var stackViewMainName: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(id)
        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(name)
        
            
        stackView.spacing = 11
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var p: UILabel = myLabel(with: "5")
    private lazy var cg: UILabel = myLabel(with: "5")
    private lazy var pts: UILabel = myLabel(with: "5")
    
    private lazy var stackViewMainNumbers: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(p)
        stackView.addArrangedSubview(cg)
        stackView.addArrangedSubview(pts)
            
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        return stackView
    }()
    
    private lazy var stackViewMainMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewMainName)
        stackView.addArrangedSubview(stackViewMainNumbers)
            
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstrains()
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
    
    func setInfo(with data: SortedByPointTeam){
        self.id.text = "\(data.position)"
        self.name.text = data.teamName
        self.p.text = "\(data.gamePlayed)"
        self.cg.text = "\(data.goalCount - data.goalMissed)"
        self.pts.text = "\(data.points)"
        
        let url = URL(string: data.teamLogo)!
        img.kf.setImage(with: url)
    }
    
}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderDetailTableViewCell{
    func setUpViews() {
        contentView.addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        img.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
    }
}
