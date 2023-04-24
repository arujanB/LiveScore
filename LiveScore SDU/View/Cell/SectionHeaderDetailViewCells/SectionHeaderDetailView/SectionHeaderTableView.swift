//
//  SectionHeaderTableView.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 24.04.2023.
//

import UIKit

final class SectionHeaderTableView: UIView {
    private lazy var id: UILabel = myLabel(with: "#", and: UIFont.boldSystemFont(ofSize: 13))
    private lazy var name: UILabel = myLabel(with: "Team", and: UIFont.boldSystemFont(ofSize: 13))
    private lazy var p: UILabel = myLabel(with: "P", and: UIFont.systemFont(ofSize: 10.5))
    private lazy var gd: UILabel = myLabel(with: "GD", and: UIFont.systemFont(ofSize: 10.5))
    private lazy var pts: UILabel = myLabel(with: "PTS", and: UIFont.systemFont(ofSize: 10.5))
    
    private lazy var stackViewIdTeam: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(id)
        stackView.addArrangedSubview(name)
            
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        return stackView
    }()

    
    private lazy var stackViewMainNumbers: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(p)
        stackView.addArrangedSubview(gd)
        stackView.addArrangedSubview(pts)
            
//        stackView.spacing = 10
        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        return stackView
    }()

    private lazy var stackViewMainMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewIdTeam)
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
}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderTableView{
    func setUpViews() {
        addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        p.snp.makeConstraints { make in
            make.width.equalTo(35)
        }
        gd.snp.makeConstraints { make in
            make.width.equalTo(35)
        }
    }
    
}
