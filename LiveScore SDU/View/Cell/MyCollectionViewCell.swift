//
//  MyCollectionViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 01.03.2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    static let IDENTIFIER = "MyCollectionViewCell"
    
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
        button.setImage(UIImage(systemName: "star.fill"), for: .focused)
        
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
            
        stackView.spacing = 20
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
        stackView.addArrangedSubview(stackViewTrailing)
            
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.init(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
        
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        img.sizeThatFits(CGSize.init(width: 3, height: 10))
            
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
    
    func setData(with data: GameScoreData) {
        time.text = data.time
        group1.text = data.firstGroup
        group2.text = data.secondGroup
        img1.image = UIImage(named: data.logo1)
        img2.image = UIImage(named: data.logo2)
        score1.text = String(data.firstScore)
        score2.text = String(data.secondScore)
        
        if data.favorite == true{
            buttonImg.setImage(UIImage(systemName: "star"), for: .normal)
        }else {
            buttonImg.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
    }
}

extension MyCollectionViewCell {
    func setUpViews() {
        contentView.addSubview(stackViewMainMommy)
    }
    
    func setUpConstrains() {
        stackViewMainMommy.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        img1.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        img2.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
    }
}
