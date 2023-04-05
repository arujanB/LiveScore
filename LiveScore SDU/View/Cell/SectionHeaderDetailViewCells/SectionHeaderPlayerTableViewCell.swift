//
//  SectionHeaderPlayerTableViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 25.03.2023.
//

import UIKit
import SnapKit
import Kingfisher

class SectionHeaderPlayerTableViewCell: UITableViewCell {
    
    static let IDENTIFIER = "SectionHeaderPlayerTableViewCell"
    
    private lazy var id: UILabel = myLabel(with: " ")
    private lazy var name: UILabel = myLabel(with: "Default")

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
        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(name)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var numberLabel: UILabel = myLabel(with: "5")

    private lazy var stackViewMainMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewMainName)
        stackView.addArrangedSubview(numberLabel)

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
    
    func setInfo(with data: PlayerStatisticsDatum){
//        self.id.text = "\(data.perGame)"
        self.name.text = "\(data.playerName)"
        self.numberLabel.text = "\(data.total)"
        
        let url = URL(string: data.teamLogo)!
        img.kf.setImage(with: url)
    }

}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderPlayerTableViewCell{
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
