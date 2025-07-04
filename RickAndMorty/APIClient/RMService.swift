//
//  RMService.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 23.04.2024.
//

import Foundation

final class RMService{

    /// Error types
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    static let shared = RMService()
    
    public init() {}
    
    public func execute<T: Codable>(
            _ request: RMRequest,
            expecting type: T.Type,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                //print(String(describing: json))
                completion(.success(json))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMetod
        return request
    }
        
}
