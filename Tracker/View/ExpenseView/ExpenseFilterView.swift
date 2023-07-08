//
//  MainTrackerView.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ExpenseViewModel
    @Namespace var animation
    @Environment(\.colorScheme) var colorScheme
    @State private var animateGradient: Bool = false
    
    var body: some View {
        ScrollView {
            tabBar()
                .padding(.bottom)
            expensesDetailCard()
            filterText()
            dateFilterSection()
            filteredCards()
            
        }
        .navigationTitle("Expense details")
    }
}

extension DetailView{
    
    @ViewBuilder
    func incomeText() -> some View {
        VStack {
            Text("\(viewModel.tabBarName == .income ? "Income" : "Expenses"):")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
    
    @ViewBuilder
    func filterText() -> some View {
        VStack {
            Text("Filter")
                .font(.title2.bold())
                .opacity (0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
    
    @ViewBuilder
    func expensesDetailCard() -> some View {
        VStack {
            Text(viewModel.convertDateToString())
                .opacity(0.7)
                .font(.footnote)
                .foregroundColor(.white)
            
            Text("Total \(viewModel.tabBarName == .income ? "income" : "expenses"):")
                .foregroundColor(.white)
            Text(viewModel.returnIncome(type: viewModel.tabBarName))
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundColor(.white)
        }
        .padding()
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(
                    LinearGradient(colors: [Color.blue, Color.cyan], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .topTrailing: .bottomTrailing)
                )
                .opacity(0.5)
                .shadow(color: .blue, radius: 10)
                .padding(.horizontal)
                .hueRotation(.degrees(animateGradient ? 90 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 9).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }
    
    @ViewBuilder
    func filteredCards() -> some View {
        ForEach(viewModel.expenses.filter { expense in
            let expenseDate = expense.date
            return expense.type == viewModel.tabBarName &&
            expenseDate >= viewModel.startDate &&
            expenseDate <= viewModel.endDate && expense.userID == viewModel.userID
        }) { expense in
            NavigationLink(destination: TransactionDetailScreen(expense: expense).environmentObject(viewModel), label: {
                TransactionCard(expense: expense)
                    .environmentObject(viewModel)
            })
            .buttonStyle(.plain)

        }
    }
    
    @ViewBuilder
    func tabBar() -> some View {
        HStack {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { tab in
                Text(tab.rawValue)
                    .fontWeight(.semibold)
                    .opacity(viewModel.tabBarName == tab ? 1 : 0.6)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, maxHeight: 27)
                    .background {
                        if viewModel.tabBarName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [Color.gray, Color.gray],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing))
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            viewModel.tabBarName = tab
                        }
                    }
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorScheme == .light ? .gray : .gray)
                .opacity(colorScheme == .light ? 0.1 : 0.2)
        )
    }
    
    @ViewBuilder
    func dateFilterSection() -> some View {
        HStack {
            HStack {
                Text("From")
                    .font(.caption)
                DatePicker("", selection: $viewModel.startDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.compact)
            }
            .padding(.horizontal)
            
            HStack {
                Text("To")
                    .font(.caption)
                DatePicker("", selection: $viewModel.endDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.compact)
            }
            .padding(.horizontal)
        }
    }
}
