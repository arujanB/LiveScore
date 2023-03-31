//
//  TeamStatisticData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 20.03.2023.
//

import Foundation

typealias TableTeamFootballData = [TableTeamFootballDatum]

// MARK: - TeamStatisticsDatum
struct TableTeamFootballDatum: Codable {
//    let teamID: Int
//    let teamName: String
//    let teamLogo: String
//
//    enum CodingKeys: String, CodingKey {
//        case teamID = "teamId"
//        case teamName, teamLogo
//    }
    
    let drawCount, gamePlayed, goalCount, goalMissed: Int
        let groupName: String
        let loseCount, points: Int
        let teamName: String
        let winCount: Int
}
