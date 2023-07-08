//
//  Currency.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let motd: MOTD
    let success: Bool
    let base, date: String
    let rates: [String: Double]
}

// MARK: - MOTD
struct MOTD: Codable {
    let msg: String
    let url: String
}
