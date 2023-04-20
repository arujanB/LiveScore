//
//  MainCellData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 02.04.2023.
//

import Foundation

// MARK: - MainCellData
struct MainCellData: Codable {
    var protocolId, gameId: Int
    let team1, team2: String
    let team1Logo: String
    let team2Logo: String
    let team1Id, team2Id: Int
    let dateAndTime, gameScore: String
    let events: [Event]
    let gameState: String
}

// MARK: - Event
struct Event: Codable {
    let eventId: Int
    let eventName, playerName: String
    let playerId, minute, teamId: Int
    let teamName, gameScore: String
    let assist: Assist?
}

//MARK: - Assist
struct Assist: Codable {
    let assistPlayer: String
    let assistPlayerId: Int
}
