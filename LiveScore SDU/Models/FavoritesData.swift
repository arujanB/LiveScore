//
//  FavoritesData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 19.04.2023.
//

import Foundation

struct FavoritesDatum: Codable {
    let tournamentName: String
    let tournamentLogo: String
    let groupName: String
    let groupID: Int
    let sortedByPointTeams: [SortedByPointTeam]

    enum CodingKeys: String, CodingKey {
        case tournamentName, tournamentLogo, groupName
        case groupID = "groupId"
        case sortedByPointTeams
    }
}

// MARK: - SortedByPointTeam
struct SortedByPointTeam: Codable {
    let position: Int
    let teamName: String
    let teamLogo: String
    let gamePlayed, winCount, drawCount, loseCount: Int
    let goalCount, goalMissed, points: Int
    let live: Bool
}

typealias FavoritesData = [FavoritesDatum]
