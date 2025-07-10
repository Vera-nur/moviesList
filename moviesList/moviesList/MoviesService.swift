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

    static func fetchPopularMovies(completion: @escaping (Result<[Movie], TMDBError>) -> Void) {
        let apiKey = getAPIKey()
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=tr"

        AF.request(url).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }

    static func searchMovies(query: String, completion: @escaping (Result<[Movie], TMDBError>) -> Void) {
        let apiKey = getAPIKey()
        guard let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.urlError))
            return
        }

        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encoded)&language=tr"

        AF.request(url).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}
