//
//  FavoritesTableViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 11.04.2023.
//

import UIKit

protocol Welcome2PageTableViewCellDelegate: AnyObject {
    func welcome2PageTableViewCell(_ welcome2PageTableViewCell: Welcome2PageTableViewCell, didFavorite item: WelcomeDatumItem)
}

class Welcome2PageTableViewCell: UITableViewCell {
    static let IDENTIFIER = "Welcome2PageTableViewCell"
    
    var outputDetail: ((Int) -> Void)?
    
    private lazy var titleSection: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "SDU Football league"
        return label
    }()
    
    private lazy var subtitleSection: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .left
        label.textColor = .gray
        label.backgroundColor = .clear
        label.text = "Almaty"
        return label
    }()
    
    private lazy var img: UIImageView = {
        var img = UIImageView()
        img.image = UIImage(named: "sdu")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(titleSection)
        stackView.addArrangedSubview(subtitleSection)
        
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(img)
        stackView.addArrangedSubview(stackViewVertical)
            
        stackView.spacing = 15
        stackView.axis = .horizontal
    //        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var buttonImg: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .orange
        
        return button
    }()
    
    private lazy var stackViewMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewHorizontal)
        stackView.addArrangedSubview(buttonImg)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    weak var delegate: Welcome2PageTableViewCellDelegate?
    private(set) var item: WelcomeDatumItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buttonImg.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToVC)))
        
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func moveToVC() {
        guard let main = item?.welcomeDatum else { return }
        outputDetail?(main.tournamentID)
    }
    
    //star button change when you click (fill)
    @objc func starButtonTapped() {
        guard let item = item else { return }
        delegate?.welcome2PageTableViewCell(self, didFavorite: item)
    }
    
    func setWelcome2Page(with model: WelcomeDatumItem) {
        item = model
        titleSection.text = model.welcomeDatum.tournamentName
        subtitleSection.text = model.welcomeDatum.tournamentType
        
        let img = UIImage(systemName: model.isFavorite ? "star.fill" : "star")
        buttonImg.setImage(img, for: .normal)
        
//        let url = URL(string: data.teamLogo)!
//        img.kf.setImage(with: url)
    }
    
}

//MARK: - setUpViews & setUpConstrains
private extension Welcome2PageTableViewCell {
    func setUpViews(){
        contentView.addSubview(stackViewMommy)
    }
    
    func setUpConstrains(){
        stackViewMommy.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        img.snp.makeConstraints { make in
            make.size.equalTo(23)
        }
    }
}
