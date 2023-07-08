//
//  ContentView.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ExpenseViewModel = .init()

    var body: some View {
        TabView {
            HomeExpenseView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
            }
            SavingsView()
                .tabItem {
                    Label("Savings", systemImage: "dollarsign")
                }
            ExchangeView()
                .tabItem{
                    Label("Exchange", systemImage: "dollarsign.arrow.circlepath")
                }
            HomeScreenView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }        .environmentObject(viewModel)

    }
}


