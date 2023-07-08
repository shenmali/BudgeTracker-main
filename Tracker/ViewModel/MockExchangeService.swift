//
//  MockExchangeService.swift
//  Tracker
//
//  Created by M.Ali SEN on 8.07.2023.
//

import Foundation

class MockExchangeService {
    func getExchangeRatesMock() async -> Data? {
        if let path = Bundle.main.path(forResource: "exchange_rates_mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Error reading JSON file: \(error)")
            }
        }
        return nil
    }
}
