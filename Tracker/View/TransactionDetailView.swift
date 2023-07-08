//
//  TransactionDetailView.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI

struct TransactionDetailScreen: View {
    var expense: Expense
    @EnvironmentObject var viewModel: ExpenseViewModel

    
    var body: some View {
        VStack {
            expenseDescription()
            expenseDetailDescription()
            expenseAmount()
            expenseType()
            expenseDate()
            Spacer()
            deleteButton()
                .padding()

        }
    }
}

private extension TransactionDetailScreen {
    @ViewBuilder
    func expenseDescription() -> some View {
        Text(expense.description)
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
    
    @ViewBuilder
    func expenseDetailDescription() -> some View {
        Text(expense.detailDescription)
            .font(.subheadline)
            .padding()
    }
    
    @ViewBuilder
    func expenseAmount() -> some View {
        HStack {
            Text("Amount:")
                .font(.headline)
            Text("\(expense.amount)")
                .font(.body)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func expenseType() -> some View {
        HStack {
            Text("Type:")
                .font(.headline)
            Text(expense.type == .expense ? "Expense" : "Income")
                .font(.body)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func expenseDate() -> some View {
        HStack {
            Text("Date:")
                .font(.headline)
            Text(expense.date.formatted(date: .long, time: .omitted))
                .font(.body)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func deleteButton() -> some View {
        Button(action: {
            deleteExpense()
        }) {
            Text("Delete")
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
        }
    }
    
    func deleteExpense() {
        guard let index = viewModel.expenses.firstIndex(of: expense) else {
            return
        }
        viewModel.deleteExpense(at: index)
    }

}
