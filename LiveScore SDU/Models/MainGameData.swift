//
//  MainGameData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 27.03.2023.
//

import Foundation

struct MainGameDatum: Codable {
    let gameID, groupID: Int
    let team1Name, team2Name: String
    let team1Logo: String
    let team2Logo: String
    let gameScore, gameState: String
    let protocolID: Int
    let gameDateTime: String

    enum CodingKeys: String, CodingKey {
        case gameID = "gameId"
        case groupID = "groupId"
        case team1Name, team2Name, team1Logo, team2Logo, gameScore, gameState
        case protocolID = "protocolId"
        case gameDateTime
    }
}

typealias MainGameData = [MainGameDatum]
