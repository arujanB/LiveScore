//
//  WelcomeData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 13.04.2023.
//

import Foundation

struct WelcomeDatum: Codable {
    let tournamentID: Int
    let tournamentName, tournamentType: String

    enum CodingKeys: String, CodingKey {
        case tournamentID = "tournamentId"
        case tournamentName, tournamentType
    }
}

typealias WelcomeData = [WelcomeDatum]
