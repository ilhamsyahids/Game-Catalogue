//
//  API.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation

class API {
    static let shared = API()
    let baseURL = "https://api.rawg.io"
    
    func getGames(query: String, page: Int, isComplete: @escaping (Result<GameResponse, GameError>) -> Void) {
        
        let endpoint = "\(baseURL)/api/games?page_size=20&search=\(query)&page=\(page)"
        
        guard let URL = URL(string: endpoint) else {
            isComplete(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL) { data, response, error in
            if let _ = error {
                isComplete(.failure(.somethingWrong))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    isComplete(.failure(.invalidResponse))
                    return
            }
            
            guard let _ = data else {
                isComplete(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(GameResponse.self, from: data!)
                isComplete(.success(games))
            } catch let error as NSError {
                print("decode error \(error)")
                isComplete(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getDeveloperList(page: Int, isComplete: @escaping (Result<DeveloperList, GameError>) -> Void) {
        
        let endpoint = baseURL + "/api/developers?page=\(page)"
        
        guard let URL = URL(string: endpoint) else {
            isComplete(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL) { data, response, error in
            if let _ = error {
                isComplete(.failure(.somethingWrong))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    isComplete(.failure(.invalidResponse))
                    return
            }
            
            guard let _ = data else {
                isComplete(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let developer = try decoder.decode(DeveloperList.self, from: data!)
                isComplete(.success(developer))
            } catch let error as NSError {
                print("decode error \(error)")
                isComplete(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
    
    
    func getGamesByDeveloper(id: Int, page: Int, isComplete: @escaping (Result<GameResponse, GameError>) -> Void) {

        let endpoint = "\(baseURL)/api/games?page_size=15&ordering=-rating&developers=\(id)&page=\(page)"

        guard let url = URL(string: endpoint) else {
            isComplete(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                isComplete(.failure(.somethingWrong))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                isComplete(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                isComplete(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let game = try decoder.decode(GameResponse.self, from: data)
                isComplete(.success(game))
            } catch let error as NSError {
                print("decode error \(error)")
                isComplete(.failure(.invalidData))
            }
        }

        task.resume()
    }

    func getGameDetail(by id: Int, isComplete: @escaping (Result<GameDetailResponse, GameError>) -> Void) {

        let endpoint = baseURL + "/api/games/\(id)"

        guard let url = URL(string: endpoint) else {
            isComplete(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                isComplete(.failure(.somethingWrong))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                isComplete(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                isComplete(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let game = try decoder.decode(GameDetailResponse.self, from: data)
                isComplete(.success(game))
            } catch let error as NSError {
                print("decode error \(error)")
                isComplete(.failure(.invalidData))
            }
        }

        task.resume()
    }

}
