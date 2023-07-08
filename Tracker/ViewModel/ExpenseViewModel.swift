//
//  ExpenseViewModel.swift
//  Tracker
//
//  Created by M.Ali SEN
//
//
import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    @Published var tabBarName : ExpenseType = .income
    @Published var dataState: DataState = .empty
    
    //adding new expenses
    @Published var addNew: Bool = false
    @Published var amount : String = ""
    @Published var type: ExpenseType = .all
    @Published var date: Date = Date()
    @Published var desc: String = ""
    @Published var detailDesc: String = ""
    let userID = Auth.auth().currentUser?.uid
    
    private let db = Firestore.firestore()
     
     func saveData(env: EnvironmentValues) {
         let expensesCollection = db.collection("expenses")
         let newExpense = Expense(description: desc, detailDescription: detailDesc, amount: Double(amount) ?? 0, date: date, type: type, color: "Yellow", userID: self.userID ?? "")
         let expenseDict: [String: Any] = [
             "description": newExpense.description,
             "detailDescription": newExpense.detailDescription,
             "amount": newExpense.amount,
             "date": newExpense.date,
             "type": newExpense.type.rawValue,
             "color": newExpense.color,
             "userID": newExpense.userID
         ]

         do {
             _ = try expensesCollection.addDocument(data: expenseDict)
             expenses.append(newExpense)
             env.dismiss()
             print(userID)
         } catch {
             print("Error writing expense to Firestore: \(error)")
         }
     }

    func fetchAllExpenses() {
        self.dataState = .loading
        Expense.fetchAll { [weak self] expenses in
            DispatchQueue.main.async {
                self?.expenses = expenses
                self?.dataState = .populated
            }
        }
    }

    func deleteExpense(at index: Int) {
        let expense = expenses[index]
        expenses.remove(at: index)
        let expenseRef = db.collection("expenses").document(expense.id)
        expenseRef.delete { error in
            if let error = error {
                print("Error deleting expense document: \(error)")
                self.expenses.insert(expense, at: index)
            }
        }
    }

    init () {
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents ([.year, .month], from: Date())
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    
    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func returnIncome(type: ExpenseType = .income) -> String {
        let currentUserExpenses = expenses.filter { $0.userID == self.userID && $0.type == type && $0.date >= startDate && $0.date <= endDate}
        let sum = currentUserExpenses.reduce(0) { $0 + $1.amount }
        return convertNumberToPrice(value: sum)
    }
    
    func returnTotal(expenses: [Expense]) -> String {
        let currentUserExpenses = expenses.filter { $0.userID == self.userID }
        
        let totalIncome = currentUserExpenses.reduce(0) { result, expense in
            if expense.type == .income {
                return result + expense.amount
            } else {
                return result
            }
        }
        
        let totalExpense = currentUserExpenses.reduce(0) { result, expense in
            if expense.type == .expense {
                return result + expense.amount
            } else {
                return result
            }
        }
        
        let total = totalIncome - totalExpense
        return convertNumberToPrice(value: total)
    }
    
    func convertExpensesToCurrency(expenses: [Expense], type: ExpenseType = .expense) -> String {
        let currentUserExpenses = expenses.filter { $0.userID == self.userID }
        let sum = currentUserExpenses.reduce(0) { $0 + $1.amount }
        return convertNumberToPrice(value: sum)
    }

    func convertDateToString() -> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter.string(from: .init(value: value)) ?? "0 EUR"
    }
    
    func clearData() {
        date = Date()
        desc = ""
        type = .all
        amount = ""
    }

}
