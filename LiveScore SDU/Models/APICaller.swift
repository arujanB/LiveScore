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
    //MARK: - Change MainGameData, it is with section name
    func fetchRequestMainGameChangeNewData(completion: @escaping ([MainGameDataChangeNewDatum]) -> Void, date: String){
        let urlString = "http://localhost:8080/game/new/date?date=\(date)"
        print(urlString)
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            do{
                let mainGameData = try JSONDecoder().decode(MainGameDataChangeNewData.self, from: data)
//                print(mainGameData[0].tournamentName)
                completion(mainGameData)
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    
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
                print("FAIL TABLE")
            }
        }
        task.resume()
    }
    
    //MARK: - PLAYER STATISTICS
    func fetchRequestPS(completion: @escaping ([PlayerStatisticsDatum]) -> Void, sectionName: String, tournamentId: Int){
        let urlString = "http://localhost:8080/player_statistics/\(sectionName)?tournament_id=\(tournamentId)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let playerStatisticsData = try? JSONDecoder().decode(PlayerStatisticsData.self, from: data) {
                completion(playerStatisticsData)
                delegate?.didFetch(with: playerStatisticsData)
            }else {
                print("FAIL PLAYER")
            }
        }
        task.resume()
    }
    
    
    //MARK: - TEAM STATISTICS
    //TEAM STATISTICS: GOALS
    func fetchRequestTSGoals(completion: @escaping ([TeamStatisticsDatum]) -> Void, id: Int){
        let urlString = "http://localhost:8080/team_statistics/goals?tournament_id=\(id)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let teamStatisticsData = try? JSONDecoder().decode(TeamStatisticsData.self, from: data) {
                completion(teamStatisticsData)
            }else {
                print("FAIL Team GOALS")
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
                print("FAIL TEAM RED YELLOW")
            }
        }
        task.resume()
    }
    
    func fetchRequestLive(completion: @escaping ([MainGameDataChangeNewDatum]) -> Void){
        let urlString = "http://localhost:8080/game/live"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let liveData = try? JSONDecoder().decode(MainGameDataChangeNewData.self, from: data) {
                completion(liveData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    //MARK: - WELCOME 2 PAGE
    func fetchRequestWelcome(completion: @escaping ([WelcomeDatum]) -> Void){
        let urlString = "http://localhost:8080/tournament"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let welcomeData = try? JSONDecoder().decode(WelcomeData.self, from: data) {
                print(welcomeData[0].tournamentName)
                completion(welcomeData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    //MARK: - FAVORITES SECTION DETAIL
    func fetchRequestFavoritesSection(completion: @escaping ([FavoritesDatum]) -> Void, tourId: Int){
        let urlString = "http://localhost:8080/group_info/all_group/points?tournamentId=\(tourId)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let favoritesData = try? JSONDecoder().decode(FavoritesData.self, from: data) {
                print(favoritesData[0].tournamentName)
                completion(favoritesData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
}
