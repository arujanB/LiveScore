//
//  TeamStatisticsData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 26.03.2023.
//

import Foundation

struct TeamStatisticsDatum: Codable {
    let statName, groupName, teamName: String
    let total: Int
    let perGame: String
}

//GOALS
typealias TeamStatisticsData = [TeamStatisticsDatum]
////ASSISTS
//typealias TeamStatisticsAssistData = [TeamStatisticsDatum]
//RED CARD
typealias TeamStatisticsRedCardData = [TeamStatisticsDatum]
//YELLOW CARD
typealias TeamStatisticsYellowCardData = [TeamStatisticsDatum]
