//
//  Page3ViewController.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 12.04.2023.
//

import UIKit

class Page3ViewController: UIViewController/*, PageProtocol*/ {
    var pageIndex: Int = 2
    
    private lazy var backgroundImg: UIImageView = {
        var img = UIImageView()
        img.image = UIImage(named: "main3")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var liveScoreLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Live Score"
        label.font = UIFont(name: "DancingScript-Bold", size: 67)
        label.numberOfLines = 0
        return label
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
extension Page3ViewController {
    func setUpViews() {
        view.addSubview(backgroundImg)
        backgroundImg.addSubview(liveScoreLabel)
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
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.87)
        }
        
        ceo.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(7)
        }
    }
}
