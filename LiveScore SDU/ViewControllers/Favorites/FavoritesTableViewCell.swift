//
//  FavoritesTableViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 11.04.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    static let IDENTIFIER = "MainTableViewCell"
    
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
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .gray
        
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buttonImg.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //star button change when you click (fill)
    @objc func starButtonTapped() {
        if buttonImg.image(for: .normal) == UIImage(systemName: "star.fill") {
            buttonImg.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            buttonImg.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
    
}

//MARK: - setUpViews & setUpConstrains
private extension FavoritesTableViewCell {
    func setUpViews(){
        addSubview(stackViewMommy)
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
