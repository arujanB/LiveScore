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
//    var url = "http://192.168.1.15:8081/"
    var url = "http://localhost:8080/"
    var delegate: AllPlayStatsData?
    
    
    
    //MARK: - MAIN GAME DATA
    //MARK: - Change MainGameData, it is with section name
    func fetchRequestMainGameChangeNewData(completion: @escaping ([MainGameDataChangeNewDatum]) -> Void, date: String){
        
        let dateString = date
        let tournaments = ["1", "2", "3"]

        var urlComponents = URLComponents(string: "\(url)game/new/date")!

        // Add the date parameter
        let dateQueryItem = URLQueryItem(name: "date", value: dateString)
        urlComponents.queryItems = [dateQueryItem]

        // Add the tournaments parameter as a list
        let tournamentsQueryItems = tournaments.map { URLQueryItem(name: "tournaments", value: $0) }
        urlComponents.queryItems?.append(contentsOf: tournamentsQueryItems)
        
                                         
//        let urlString = "\(url)game/new/date?date=\(date)"
//        print(urlString)
        print("COMPONENTS: \(urlComponents)")
//        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        guard let url = URL(string: "\(urlComponents)") else { fatalError("Error urlString in APICaller") }
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
        let urlString = "\(url)game/date?date=\(date)"
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
        let urlString = "\(url)game/date?date=\(date)"
        
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
        let urlString = "\(url)protocol/\(protocolId)"
        
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
    func fetchRequestTable(completion: @escaping ([FavoritesDatum]) -> Void, grouId: Int, tourId:Int){
        let urlString = "\(url)group_info/group/points?groupId=\(grouId)&tournamentId=\(tourId)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let tableData = try? JSONDecoder().decode(FavoritesData.self, from: data) {
                completion(tableData)
                print(tableData[0].groupID)
                print("TOURNAMENT ID \(tourId)")
            }else {
                print("FAIL TABLE")
            }
        }
        task.resume()
    }
    
    //MARK: - PLAYER STATISTICS
    func fetchRequestPS(completion: @escaping ([PlayerStatisticsDatum]) -> Void, sectionName: String, tournamentId: Int){
        let urlString = "\(url)player_statistics/\(sectionName)?tournament_id=\(tournamentId)"
        
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
        let urlString = "\(url)team_statistics/goals?tournament_id=\(id)"
        
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
        let urlString = "\(url)team_statistics/\(sectionName)/\(id)"
        
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
        let urlString = "\(url)game/live"
        
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
        let urlString = "\(url)tournament"
        
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
        let urlString = "\(url)group_info/all_group/points?tournamentId=\(tourId)"
        
        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let favoritesData = try? JSONDecoder().decode(FavoritesData.self, from: data) {
//                print(favoritesData[0].tournamentName)
                completion(favoritesData)
            }else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    //MARK: - SEARCH BUTTON
//    func fetchRequestSearch(completion: WelcomeDatum, searchName: String = ""){
//        let urlString = "http://localhost:8080/tournament/tournament_name?name=\(searchName)"
//
//        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
//        let request = URLRequest(url: url)
//
//        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
//            guard let data else { return }
//            if let favoritesData = try? JSONDecoder().decode(WelcomeData.self, from: data) {
//                print(favoritesData)
//            }else {
//                print("FAIL SEARCH BUTTON")
//            }
//        }
//        task.resume()
//    }
    
    func fetchRequestSearch(completion: @escaping ([WelcomeDatum]) -> Void, searchName: String = ""){
        let urlString = "\(url)tournament/tournament_name?name=\(searchName)"

        guard let url = URL(string: urlString) else { fatalError("Error urlString in APICaller") }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data else { return }
            if let favoritesData = try? JSONDecoder().decode([WelcomeDatum].self, from: data) {
                DispatchQueue.main.async {
                    completion(favoritesData)
                }
                print(favoritesData)
            }else {
                print("FAIL SEARCH BUTTON")
            }
        }
        task.resume()
    }
    
}
