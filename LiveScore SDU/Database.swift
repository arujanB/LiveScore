//
//  Constants.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 07.03.2023.
//

import Foundation
import UIKit

struct Database {
    static var nameLocationDataArray:[NameLocationData] = [
        NameLocationData(footballName: "SDU Football league", location: "Almaty", logo: UIImage(named: "sdu")),
        NameLocationData(footballName: "NU Football league", location: "Astana", logo: UIImage(named: "nu")),
        NameLocationData(footballName: "KBTU Football league", location: "Almaty", logo: UIImage(named: "kbtu"))
    ]
    
    static var gameScoreDataArray:[GameScoreData] = [
        GameScoreData(time: "19:00", logo1: "barbara", logo2: "sunkara", firstGroup: "Barbara", secondGroup: "Sunkar", firstScore: 0, secondScore: 3, favorite: false),
        GameScoreData(time: "21:00", logo1: "real", logo2: "kairat", firstGroup: "Real Madrid", secondGroup: "Kairat", firstScore: 0, secondScore: 2, favorite: false),
        GameScoreData(time: "22:00", logo1: "barbara", logo2: "chelsea", firstGroup: "Barbara", secondGroup: "Chelsea", firstScore: 1, secondScore: 1, favorite: true),
        GameScoreData(time: "23:00", logo1: "barsa", logo2: "sunkara", firstGroup: "Barselona", secondGroup: "Sunkar", firstScore: 0, secondScore: 0, favorite: false),
        GameScoreData(time: "00:00", logo1: "real", logo2: "barsa", firstGroup: "Real Madrid", secondGroup: "Barselona", firstScore: 2, secondScore: 3, favorite: true)
    ]
    
    static var playerInfoArray: [PlayersInfoData] = [
//        PlayersInfoData(id: 1, logo: "barbara", name: "Qfrfwer", p: 4, cg: 6, pts: 7),
//        PlayersInfoData(id: 2, logo: "real", name: "Hefef", p: 3, cg: 4, pts: 14),
//        PlayersInfoData(id: 3, logo: "kairat", name: "Ifwe", p: 4, cg: 6, pts: 15),
//        PlayersInfoData(id: 4, logo: "sunkara", name: "Merfrfe", p: 4, cg: 8, pts: 13),
//        PlayersInfoData(id: 5, logo: "barsa", name: "Owefwf", p: 7, cg: 6, pts: 12),
//        PlayersInfoData(id: 6, logo: "barbara", name: "Lfwfe", p: 9, cg: 3, pts: 1),
//        PlayersInfoData(id: 7, logo: "real", name: "Pfwfw", p: 2, cg: 6, pts: 20)
    ]

}

struct NameLocationData {
    var footballName: String
    var location: String
    var logo: UIImage?
}

struct GameScoreData {
    var time: String
    var logo1: String
    var logo2: String
    var firstGroup: String
    var secondGroup: String
    var firstScore: Int
    var secondScore: Int
    var favorite: Bool
}

struct PlayersInfoData {
    var id: Int
    var logo: String
    var name: String
    var p: Int
    var cg: Int
    var pts: Int
    let groupName, teamName: String
    let gamePlayed, winCount, drawCount, loseCount: Int
    let goalCount, goalMissed, points: Int
}
/*
 let groupName, teamName: String
 let gamePlayed, winCount, drawCount, loseCount: Int
 let goalCount, goalMissed, points: Int
 
 */
