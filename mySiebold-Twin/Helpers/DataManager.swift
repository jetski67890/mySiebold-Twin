//
//  DataManager.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import Foundation

// Custom Error type
enum DataManagerError: Error {
    case invalidURL
    case noData
}

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
    
    // Fetch Menus
    func fetchMenus(completion: @escaping (Result<[Menu]>) -> Void) {
        fetchData(endpoint: "/menu", completion: completion)
    }
    
    private func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<[T]>) -> Void) {
        let urlString = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        NetworkManager.shared.getData(from: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(DataManagerError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let items = try decoder.decode([T].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
