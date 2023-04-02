//
//  MainCellData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 02.04.2023.
//

import Foundation

// MARK: - MainCellData
struct MainCellData: Codable {
    let protocolId, gameId: Int
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
    let penalty: Bool
}

//MARK: - Assist
struct Assist: Codable {
    let assistPlayer: String
    let assistPlayerId: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
