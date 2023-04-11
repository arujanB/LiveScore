//
//  MainGameDataChangeNewData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 08.04.2023.
//

//MARK: - UPDATE OF THE MAINGAMEDATA , THIS IS JUST TO UNDERSTAND OF CONNECTING TO BACK PART

import Foundation

struct MainGameDataChangeNewDatum: Codable {
    let tournamentId: Int
    let groupId: Int
    let tournamentName: String
    let tournamentLogo: String
    let groupName: String
    let games: [Game]
}

// MARK: - Game
struct Game: Codable {
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

typealias MainGameDataChangeNewData = [MainGameDataChangeNewDatum]
