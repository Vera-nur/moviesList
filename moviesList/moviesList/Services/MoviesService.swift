//
//  MoviesService.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import Foundation
import Alamofire

enum TMDBError: Error {
    case urlError
    case networkError(Error)
    case decodingError
    case unknown
}

struct TMDBService {
    
    private static let BaseUrl = "https://api.themoviedb.org/3"
        
    
    static private func getAPIKey() -> String {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let apiKey = dict["API_KEY"] as? String
        else {
            fatalError("API Key not found in Config.plist")
        }

        return apiKey
    }
    
    private static func request <T: Decodable>(endpoint: String, parameters: [String: Any] = [:], completion: @escaping (Result<T, TMDBError>) -> Void) {
        var allParameters = parameters
        allParameters["api_key"] = getAPIKey()
        allParameters["language"] = "en-US"
        
        let url = "\(BaseUrl)\(endpoint)"
        
        AF.request(url, parameters: allParameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.networkError(error)))
                }
            
        }
    }

    static func fetchPopularMovies(completion: @escaping (Result<[Movie], TMDBError>) -> Void) {
        request(endpoint: "/movie/popular") {(result: Result<MovieResponse, TMDBError>) in
                switch result {
                case .success(let response):
                    completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

    static func searchMovies(query: String, completion: @escaping (Result<[Movie], TMDBError>) -> Void) {
        guard let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.urlError))
            return
        }
        
        request(endpoint: "/search/movie", parameters: ["query" : encoded]) {(result: Result<MovieResponse, TMDBError>) in
                switch result {
                case .success(let response):
                    completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
