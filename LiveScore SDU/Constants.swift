//
//  Constants.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 13.03.2023.
//

import Foundation
import UIKit

struct Constants {
    struct Links{
        let apiUrl = "http://localhost:8080/"
    }
}

//MARK: - Enum: Header names
enum DetailSegment: String {
    case button = "OverView"
    case matches = "Matches"
    case table = "Table"
    case stat = "Player Stats"
    case last = "Team Stats"
}

//MARK: - Enum: Header names
enum APIStats: String {
    case goals = "goals"
    case assist = "assists"
    case redCard = "red_card"
    case yellowCard = "yellow_card"
//    case last = "Team Stats"
}
//MARK: - Enum: MainScoreViewController
enum ScoreSegment {
    case first
    case yesterday
    case today
    case tomorrow
    case last
}

//MARK: - Segment RemoveBorder
extension UISegmentedControl {
func removeBorders() {
    setBackgroundImage(imageWithColor(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
//    setBackgroundImage(imageWithColor(color: .orange), for: .selected, barMetrics: .default)
    setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
}

// create a 1x1 image with this color
private func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor);
    context!.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image!
    }
}

//Date
struct DateModel {
    var week: String
    var day: String
    var month: String
}

 typealias DateData = [DateModel]
