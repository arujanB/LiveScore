//
//  PlayerStatisticsData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 25.03.2023.
//

import Foundation

//struct PlayerStatisticsDatum: Codable {
//    let playerID, groupID, matchPlayed, goals: Int
//    let assists, yellowCard, redCard: Int
//
//    enum CodingKeys: String, CodingKey {
//        case playerID = "playerId"
//        case groupID = "groupId"
//        case matchPlayed, goals, assists, yellowCard, redCard
//    }
//}

struct PlayerStatisticsDatum: Codable {
    let statName, teamName: String
    let teamLogo: String
    let playerName: String
    let total: Int
    let perGame: String
}

//GOALS
typealias PlayerStatisticsData = [PlayerStatisticsDatum]
//ASSISTS
typealias PlayerStatisticsAssistData = [PlayerStatisticsDatum]
//RED CARD
typealias PlayerStatisticsRedCardData = [PlayerStatisticsDatum]
//YELLOW CARD
typealias PlayerStatisticsYellowCardData = [PlayerStatisticsDatum]
