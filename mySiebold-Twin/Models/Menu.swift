//
//  Menu.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import Foundation

struct Menu: Codable {
    let id: String
    let date: String
    let breakfast: Meal
    let lunch: Meal
    let snack: String

    struct Meal: Codable {
        let main: String
        let side: String
        let dessert: String
        let beverage: String
    }
}
