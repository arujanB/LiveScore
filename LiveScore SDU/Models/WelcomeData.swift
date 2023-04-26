//
//  WelcomeData.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 13.04.2023.
//

import Foundation

struct WelcomeDatumItem: Codable {
    var welcomeDatum: WelcomeDatum
    var isFavorite: Bool
}

struct WelcomeDatum: Codable {
    let tournamentID: Int
    let tournamentName, tournamentType: String

    enum CodingKeys: String, CodingKey {
        case tournamentID = "tournamentId"
        case tournamentName, tournamentType
    }
    
//    //USER DEFAULT SAVE DATA
//    var saveMainCellToFav: [WelcomeDatum] {
//        get{
//            if let data = UserDefaults.standard.value(forKey: "cells") as? Data {
//                return try! PropertyListDecoder().decode([WelcomeDatum].self, from: data)
//            }else {
//                return [WelcomeDatum]()
//            }
//        }
//
//        set {
//            if let data = try? PropertyListEncoder().encode(newValue){
//                UserDefaults.standard.set(data, forKey: "cells")
//            }
//        }
//    }
//
//    mutating func saveCells(tournamentID: Int, tournamentName: String, tournamentType: String) {
//        let cells = WelcomeDatum(tournamentID: tournamentID, tournamentName: tournamentName, tournamentType: tournamentType)
//        saveMainCellToFav.insert(cells, at: 0)
//    }
}

typealias WelcomeData = [WelcomeDatum]
