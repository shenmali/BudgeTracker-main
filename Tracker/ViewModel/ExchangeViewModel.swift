import Foundation
import SwiftUI

@MainActor
class ExchangeViewModel: ObservableObject {
    
    @Published var results: Welcome?
    @Published var amount = ""
    @Published var baseCurrency = "USD"
    @Published var secondCurrency = "EUR"
    @Published var result = ""
    var mockEnabled = false
    
    func getExchangeRates() async {
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=USD&amount=1000") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.results = try JSONDecoder().decode(Welcome.self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func getExchangeRatesMock() async {
        if let data = await MockExchangeService().getExchangeRatesMock() {
            do {
                self.results = try JSONDecoder().decode(Welcome.self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    func convert() {
        guard let amount = Double(amount),
              let baseRate = results?.rates[baseCurrency],
              let destinationRate = results?.rates[secondCurrency]
        else { return }
        
        var doubleResult = 0.0
        doubleResult = ((amount / baseRate) * destinationRate)
        let formattedString = String(format: "%.2f", doubleResult)
        result = "\(formattedString) \(secondCurrency)"
    }
    
    func fetchData() async {
        if mockEnabled {
            await getExchangeRatesMock()
        } else {
            await getExchangeRates()
        }
    }
}
