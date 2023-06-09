//
//  MyCollectionViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 01.03.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    static let IDENTIFIER = "MainCollectionViewCell"
    
    var outputDetail: (() -> Void)?
    
    private lazy var time:UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        
        return label
    }()
    
    //create into cell
    private lazy var group1:UILabel = groupName(group: "Barbara")
    private lazy var group2:UILabel = groupName(group: "Sunkar")
    private lazy var img1: UIImageView = groupImg(img: "logo")
    private lazy var img2: UIImageView = groupImg(img: "logo")
    private lazy var score1:UILabel = groupScore(score: 0)
    private lazy var score2:UILabel = groupScore(score: 0)
    
    private lazy var buttonImg: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .gray
        
        return button
        
        //kerek bolad
//        let origImage = UIImage(named: "imageName")
//        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//        btn.setImage(tintedImage, forState: .normal)
//        btn.tintColor = .redColor
    }()
    
    //stackView
    private lazy var stackViewName: UIStackView = stackViewHorizontal(first: img1, second: group1)
    private lazy var stackViewName2: UIStackView = stackViewHorizontal(first: img2, second: group2)
    
    private lazy var stackViewMainName: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewName)
        stackView.addArrangedSubview(stackViewName2)
            
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var stackViewMainScore: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(score1)
        stackView.addArrangedSubview(score2)
            
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        return stackView
    }()
    
    private lazy var stackViewLeading: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(time)
        stackView.addArrangedSubview(stackViewMainName)
            
        stackView.spacing = 10
//        stackView.backgroundColor = .systemGreen
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var stackViewTrailing: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewMainScore)
        stackView.addArrangedSubview(buttonImg)
            
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
//    private lazy var stackViewMainMommy: UIStackView = {
//        var stackView = UIStackView()
//        stackView.addArrangedSubview(time)
//        stackView.addArrangedSubview(stackViewMainName)
//        stackView.addArrangedSubview(stackViewMainScore)
//        stackView.addArrangedSubview(buttonImg)
//
//        stackView.spacing = 5
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        return stackView
//    }()
    
    private lazy var stackViewMainMommy: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(stackViewLeading)
        stackView.addArrangedSubview(stackViewMainScore)
            
//        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    func configure(with model: Game) {
        group1.text = model.team1Name
        group2.text = model.team2Name
        
        let url1 = URL(string: model.team1Logo)!
        img1.kf.setImage(with: url1)
        
        let url2 = URL(string: model.team2Logo)!
        img2.kf.setImage(with: url2)
        
        let timeString = model.gameScore
        let components = timeString.components(separatedBy: ":")
        
        score1.text = components[0]
        score2.text = components[1]
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = format.date(from: model.gameDateTime)
        format.dateFormat = "HH:mm"
        
//        time.text = format.string(from: date!)
        if model.gameState == "ENDED" {
            time.text = "  FT  "
            time.textColor = .white
        }else if model.gameState == "STARTED" {
            time.text = " Live "
            time.textColor = .orange
        }else {
            time.text = format.string(from: date!)
            time.textColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        
        buttonImg.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        
        setUpViews()
        setUpConstrains()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToVC)))
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
    
    func groupName(group name:String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        label.text = name
        
        return label
    }
    func groupImg(img name: String) -> UIImageView {
        let img = UIImageView()
        img.image = UIImage(named: name)
//        img.sizeThatFits(CGSize.init(width: 3, height: 10))
        img.sizeThatFits(CGSize.init(width: 2, height: 20))
            
        img.layer.cornerRadius = 10 //it works with maskToBounds /*do not forget it to use*/
        img.layer.masksToBounds = true
                
        return img
    }
    func groupScore(score num:Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
//        label.textAlignment = .left
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        label.text = "\(num)"
        
        return label
    }
    func stackViewHorizontal(first: UIImageView, second: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.addArrangedSubview(first)
        stackView.addArrangedSubview(second)
            
        stackView.spacing = 5
        stackView.axis = .horizontal
//        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }
    
    @objc private func moveToVC() {
        outputDetail?()
     }
}

extension MainCollectionViewCell {
    func setUpViews() {
        contentView.addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        img1.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        img2.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
    }
}
