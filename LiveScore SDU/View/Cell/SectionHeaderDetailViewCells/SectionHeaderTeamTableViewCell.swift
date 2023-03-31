//
//  SectionHeaderTeamTableViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 26.03.2023.
//

import UIKit
import SnapKit

class SectionHeaderTeamTableViewCell: UITableViewCell {
    static let IDENTIFIER = "SectionHeaderTeamTableViewCell"
    var counter = 0
    private lazy var id: UILabel = myLabel(with: "")
    private lazy var name: UILabel = myLabel(with: "Default")
//    func c() -> Int {
//        for i in 1...100{
//            counter += i
//            return counter
//        }
//
//        return counter
//    }
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "sdu")
        img.sizeThatFits(CGSize.init(width: 5, height: 5))

        img.layer.cornerRadius = 10 //it works with maskToBounds /*do not forget it to use*/
        img.layer.masksToBounds = true

        return img
    }()

    private lazy var stackViewMainName: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(id)
//        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(name)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var total: UILabel = myLabel(with: "5")
    private lazy var perGame: UILabel = myLabel(with: "5")
    
    private lazy var stackViewMainNumbers: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(perGame)
        stackView.addArrangedSubview(total)
            
        stackView.spacing = 40
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
        counter = counter + 1
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
    
    func setInfo(with data: TeamStatisticsDatum){
        
//        self.id.text = "\(counter)"
        self.name.text = "\(data.teamName)"
        self.total.text = "\(data.total)"
        self.perGame.text = "\(data.perGame)"
        
//        let url = URL(string: data.teamLogo)!
//        img.kf.setImage(with: url)
    }

}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderTeamTableViewCell{
    func setUpViews() {
        contentView.addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        img.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        
    }
}
