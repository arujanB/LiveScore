//
//  SectionHeaderTeamView.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 26.03.2023.
//

import UIKit

final class SectionHeaderTeamView: UIView {
    private lazy var name: UILabel = myLabel(with: "Default", and: UIFont.boldSystemFont(ofSize: 13))
    private lazy var perGame: UILabel = myLabel(with: "Per Game", and: UIFont.systemFont(ofSize: 10.5))
    private lazy var total: UILabel = myLabel(with: "Total", and: UIFont.systemFont(ofSize: 10.5))
    
    private lazy var stackViewMainNumbers: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(perGame)
        stackView.addArrangedSubview(total)
            
//        stackView.spacing = 10
        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        return stackView
    }()

    private lazy var stackViewMainMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(stackViewMainNumbers)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func myLabel(with value: String, and size: UIFont) -> UILabel {
        let label = UILabel()
        label.font = size
        label.text = value
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func setName(with name: String) {
        self.name.text = name
    }
}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderTeamView{
    func setUpViews() {
        addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        perGame.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    
}
