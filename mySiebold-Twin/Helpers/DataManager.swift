//
//  DataManager.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private let baseURL = "https://mysiebold-backend.onrender.com"
    
    private init() {}
    
    enum Result<T> {
        case success(T)
        case failure(Error)
    }

    // Fetch Appointments
    func fetchAppointments(completion: @escaping (Result<[Appointment]>) -> Void) {
        fetchData(endpoint: "/appointments", completion: completion)
    }
    
    // Fetch Substitutions
    func fetchSubstitutions(completion: @escaping (Result<[Substitution]>) -> Void) {
        fetchData(endpoint: "/plan", completion: completion)
    }
    
    private func fetchData<T: Decodable>(endpoint: String, isArrayResponse: Bool = true, completion: @escaping (Result<[T]>) -> Void) {
        let urlString = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if isArrayResponse {
                    let items = try decoder.decode([T].self, from: data)
                    completion(.success(items))
                } else {
                    let item = try decoder.decode(T.self, from: data)
                    completion(.success([item]))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
