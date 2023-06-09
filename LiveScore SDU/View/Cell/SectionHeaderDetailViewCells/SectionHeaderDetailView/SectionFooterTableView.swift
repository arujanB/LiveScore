//
//  SectionFooterTableView.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 05.05.2023.
//

import UIKit
import SnapKit

class SectionFooterTableView: UITableViewHeaderFooterView {
    static let IDENTIFIER = "SectionFooterTableView"
    
    var section: Int?
    
    private lazy var seeAll: UILabel = {
        var label = UILabel()
        label.text = "See All"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToVC)))
//
//        setUpViews()
//        setUpConstraints()
//    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setUpViews()
        setUpConstraints()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        section = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setSeeAll(with text: String) {
        seeAll.text = text
    }
}

//MARK: - setUpViews and setUpConstraints
extension SectionFooterTableView{
    func setUpViews(){
        addSubview(seeAll)
    }
    
    func setUpConstraints(){
        seeAll.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
