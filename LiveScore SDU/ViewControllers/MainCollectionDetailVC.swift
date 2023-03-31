//
//  MyCollectionDetailVC.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 16.03.2023.
//

import UIKit

class MainCollectionDetailVC: UIViewController {
    static let IDENTIFIER = "MyCollectionDetailVC"

    private lazy var group1Name = groupName(group: "Barabar")
    private lazy var group2Name = groupName(group: "Barabar")
    
    private lazy var group1Img = groupImg(img: "barabar")
    private lazy var group2Img = groupImg(img: "barabar")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)

        // Do any additional setup after loading the view.
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

}

//MARK: - Navigation
extension MainCollectionDetailVC {
    private func setNav() {
        createCustomNavigationBar()
        
        let audioRightButton = createCustomButton(
            imageName: "phone",
            selector: #selector(audioRightButtonTapped)
        )
        let videoRightButton = createCustomButton(
            imageName: "video",
            selector: #selector(videoRightButtonTapped)
        )
        
        navigationItem.rightBarButtonItems = [audioRightButton, videoRightButton]
    }
    
    @objc private func audioRightButtonTapped() {
        print("audioRightButtonTapped")
    }
    
    @objc private func videoRightButtonTapped() {
        print("videoRightButtonTapped")
    }
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
    
            let button = UIButton(type: .system)
            button.setImage(
                UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
                for: .normal
            )
            button.tintColor = .systemBlue
            button.imageView?.contentMode = .scaleAspectFit
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.addTarget(self, action: selector, for: .touchUpInside)
    
            let menuBarItem = UIBarButtonItem(customView: button)
            return menuBarItem
        }
}
