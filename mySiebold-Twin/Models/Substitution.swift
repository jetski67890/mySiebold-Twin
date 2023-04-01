//
//  Substitution.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import Foundation

struct Substitution: Codable {
    let id: String
    let `class`: String
    let date: String
    let startTime: String
    let endTime: String
    let subject: String
    let teacher: String
    let room: Room
    let info: String
}

struct Room: Codable {
    let number: String
    let name: String
}
