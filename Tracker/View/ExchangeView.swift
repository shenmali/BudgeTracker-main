//
//  ExchangeView.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI

struct ExchangeView: View {
    @State private var isKeyboardVisible = false

    @ObservedObject var viewModel = ExchangeViewModel()
    @State private var showBaseCurrencyPicker = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                 amountTextField()
                 initialCurrencyPicker()
                    Text("to")
                destinationCurrencyPicker()
                }.padding(.horizontal)
                convertButton()
                resultText()
                Spacer()
            }
            .padding(.top, 12)
            .onAppear{
                Task{
                    await viewModel.getExchangeRates()
                }
            }
            .navigationTitle("Currency converter")
        }
    }    
}

extension ExchangeView {
    
    @ViewBuilder
    func initialCurrencyPicker() -> some View {
        Picker("Initial currency", selection: $viewModel.baseCurrency) {
            ForEach(viewModel.results?.rates.keys.sorted() ?? [], id: \.self) { key in
                Text(key)
            }
        }
    }
    
    @ViewBuilder
    func destinationCurrencyPicker() -> some View {
        Picker("Destination currency", selection: $viewModel.secondCurrency){
            ForEach(viewModel.results?.rates.keys.sorted() ?? [], id: \.self) {key in
                Text(key)
            }
        }
        .pickerStyle(.menu)
    }
    
    @ViewBuilder
    func amountTextField() -> some View {
        ZStack(alignment: .bottom) {
            TextField("Enter amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
            
            if isKeyboardVisible {
                HStack {
                    Spacer()
                    Button("OK") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .padding(.bottom, 5)
                    .padding(.trailing, 4)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation {
                isKeyboardVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation {
                isKeyboardVisible = false
            }
        }
    }
    
   @ViewBuilder
    func convertButton() -> some View {
        Button("Convert") {
            viewModel.convert()
        }
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.results == nil || viewModel.amount == "")
    }
    
    @ViewBuilder
    func resultText() -> some View {
        Text("\(viewModel.result)")
            .padding(.top, 12)
            .font(.largeTitle)
    }
}
