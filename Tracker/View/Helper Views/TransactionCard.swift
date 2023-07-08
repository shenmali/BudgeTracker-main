//
//  TransactionCard.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI

struct TransactionCard: View {
    var expense: Expense
    @EnvironmentObject var viewModel : ExpenseViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Text(expense.description)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 5){
                let price = viewModel.convertNumberToPrice(value: expense.type == .expense ? -expense.amount : expense.amount)
                Text(price)
                    .font(.callout)
                    .foregroundColor(expense.type == .expense ? .red : .green)
                Text(expense.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
            }
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.linearGradient(colors: [Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .opacity(colorScheme == .light ? 0.1 : 0.2))
            .padding(.horizontal)
    }
}

