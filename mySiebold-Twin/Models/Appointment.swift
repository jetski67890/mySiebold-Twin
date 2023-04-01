//
//  Appointment.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import Foundation

struct Appointment: Codable {
    let id: Int
    let title: String
    let date: String
    let startTime: String
    let endTime: String
    let location: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case date
        case startTime
        case endTime
        case location
        case description
    }
}
