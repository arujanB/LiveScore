//
//  Page1ViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 12.04.2023.
//

import UIKit
import SnapKit

class Page1ViewController: UIViewController/*, PageProtocol*/ {
    var pageIndex: Int = 0

    private lazy var backgroundImg: UIImageView = {
        var img = UIImageView()
        img.image = UIImage(named: "main")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var liveScoreLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Live Score"
        label.font = UIFont(name: "DancingScript-Bold", size: 70)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "WELCOME"
        label.font = UIFont(name: "BebasNeue-Regular", size: 80)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Never miss a goal - Get live match\n alerts, fixtures and results for your\n favourite team and competitions"
        label.font = UIFont(name: "DancingScript-Medium", size: 5)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var stackViewWelcome: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [welcomeLabel, textLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private lazy var ceo: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "©2023 Arsensio_20"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpConstrains()
        
        view.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)
    }

}

//MARK: - setUpViews & setUpConstrains
extension Page1ViewController {
    func setUpViews() {
        view.addSubview(backgroundImg)
        backgroundImg.addSubview(liveScoreLabel)
        backgroundImg.addSubview(stackViewWelcome)
        backgroundImg.addSubview(ceo)
    }
    
    func setUpConstrains(){
        backgroundImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        liveScoreLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.87)
        }
        
        stackViewWelcome.snp.makeConstraints { make in
            make.top.equalTo(liveScoreLabel.snp.bottom).offset(93)
            make.leading.trailing.equalToSuperview()
        }
        
        ceo.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(7)
        }
    }
}
