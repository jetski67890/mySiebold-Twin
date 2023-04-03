//
//  NetworkManager.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 03.04.23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // Generic method for fetchig data
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
}
