//
//  SavingsViewModel.swift
//  Tracker
//
//  Created by M.Ali SEN
//
import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor class SavingsViewModel: ObservableObject {
    @Published var savings: [Saving] = []
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
    // Adding new savings
    @Published var addNew: Bool = false
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var desc: String = ""
    @Published var dataState: DataState = .empty
    let userID = Auth.auth().currentUser?.uid
    
    let db = Firestore.firestore()
    
    func saveData(env: EnvironmentValues) {
        let savingsCollection = db.collection("savings")
        let newSaving = Saving(amount: Double(amount) ?? 0, date: date, userID: userID ?? "")
        let savingDict: [String: Any] = [
            "amount": newSaving.amount,
            "date": Timestamp(date: newSaving.date),
            "userID": newSaving.userID
        ]

        do {
            _ = try savingsCollection.addDocument(data: savingDict)
            savings.append(newSaving)
            env.dismiss()
        } catch {
            print("Error writing saving to Firestore: \(error)")
        }
    }    
    
    func fetchAllSavings() {
        self.dataState = .loading
        Saving.fetchAll { [weak self] savings in
            DispatchQueue.main.async {
                self?.savings = savings
                self?.dataState = .populated
            }
        }
    }
    
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter.string(from: .init(value: value)) ?? "0 EUR"
    }
    
    init() {
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents ([.year, .month], from: Date())
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    
    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func returnTotalSavings() -> String {
        let sum = savings.reduce(0) { $0 + $1.amount }
        return convertNumberToPrice(value: sum)
    }
    
    
    func clearData() {
        date = Date()
        desc = ""
        amount = ""
    }
}
