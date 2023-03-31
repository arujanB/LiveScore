//
//  SectionDetailCollectionViewCell.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 15.03.2023.
//

import UIKit
import SnapKit

class SectionHeaderStatsCollectionViewCell: UICollectionViewCell {
    static let IDENTIFIER = "SectionHeaderStatsCollectionViewCell"
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "hello"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: String) {
        name.text = data
    }
}

//MARK: - setUpViews & setUpConstrains
extension SectionHeaderStatsCollectionViewCell {
    func setUpViews() {
        contentView.addSubview(name)
    }
    func setUpConstrains(){
        name.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
