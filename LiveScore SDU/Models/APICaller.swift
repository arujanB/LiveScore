//
//  APICaller.swift
//  LiveScore SDU
//
//  Created by Aruzhan Boranbay on 13.03.2023.
//

import Foundation

protocol AllPlayStatsData {
    func didFetch(with: [PlayerStatisticsDatum])
}

struct APICaller {
    var delegate: AllPlayStatsData?
    
    //MARK: - MAIN GAME DATA
    //Change
    func fetchRequestMainGameChange(completion: @escaping ([MainGameDatum]) -> Void, date: String){
        let urlString = "http://localhost:8080/game/date?date=\(date)"
        print(urlString)
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            do{
                let mainGameData = try JSONDecoder().decode(MainGameData.self, from: data)
                completion(mainGameData)
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchRequestMainGame(completion: @escaping ([MainGameDatum]) -> Void, date: String){
//        let urlString = "http://localhost:8080/game/date?date=2023-03-06"
        let urlString = "http://localhost:8080/game/date?date=\(date)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let mainGameData = try? JSONDecoder().decode(MainGameData.self, from: data) {
                completion(mainGameData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    //MARK: - MAIN CELL DATA
    func fetchRequestMainCell(completion: @escaping (MainCellData) -> Void, protocolId: Int){
        let urlString = "http://localhost:8080/protocol/\(protocolId)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let dataCell = try? JSONDecoder().decode(MainCellData.self, from: data) {
                completion(dataCell)
//                print("AAAAAAA...............AAAAAAAAA\(dataCell.gameId)")
            }else {
                print("FAIL UUUUUU")
            }
        }
        task.resume()
    }
    
    //MARK: - TABLE TEAM FOOTBALL
    func fetchRequestTable(completion: @escaping ([TableTeamFootballDatum]) -> Void){
        let urlString = "http://localhost:8080/team_statistics/points?groupId=1"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let teamStatisticsData = try? JSONDecoder().decode(TableTeamFootballData.self, from: data) {
                completion(teamStatisticsData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    //MARK: - PLAYER STATISTICS
    func fetchRequestPS(completion: @escaping ([PlayerStatisticsDatum]) -> Void, sectionName: String, groupId: Int){
        let urlString = "http://localhost:8080/player_statistics/\(sectionName)?groupId=\(groupId)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let playerStatisticsData = try? JSONDecoder().decode(PlayerStatisticsData.self, from: data) {
//                print(playerStatisticsData[0].assists)
                completion(playerStatisticsData)
                delegate?.didFetch(with: playerStatisticsData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    
    //MARK: - TEAM STATISTICS
    //TEAM STATISTICS: GOALS
    func fetchRequestTSGoals(completion: @escaping ([TeamStatisticsDatum]) -> Void, id: Int){
        let urlString = "http://localhost:8080/team_statistics/goals?groupId=\(id)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let teamStatisticsData = try? JSONDecoder().decode(TeamStatisticsData.self, from: data) {
                completion(teamStatisticsData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    //TEAM STATISTICS: RED CARD, YELLOW CARD
    func fetchRequestTS(completion: @escaping ([TeamStatisticsDatum]) -> Void, sectionName: String, id: Int){
        let urlString = "http://localhost:8080/team_statistics/\(sectionName)/\(id)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let teamStatisticsRedCardData = try? JSONDecoder().decode(TeamStatisticsRedCardData.self, from: data) {
                completion(teamStatisticsRedCardData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
}
