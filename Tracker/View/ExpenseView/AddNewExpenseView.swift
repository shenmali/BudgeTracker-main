//
//  NewExpenseView.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI

struct NewExpenseView: View {
    @EnvironmentObject var viewModel: ExpenseViewModel
    @Environment (\.self) var env
    var body: some View {
        VStack{
            VStack{
                titleText()
                amountTextfield()
                descriptionText()
                detailDescriptionText()
                datePicker()
                checkboxSelection()
                Spacer()
                saveButton()
            }
        }
    }
}

extension NewExpenseView {
    @ViewBuilder
    func titleText() -> some View {
        Text("Add Expenses")
            .font(.title2)
            .fontWeight(.semibold)
            .opacity(0.5)
            .padding(.top, 15)
    }
    
    @ViewBuilder
    func amountTextfield() -> some View {
        if let symbol = viewModel.convertNumberToPrice(value:0).first{
            TextField("0", text: $viewModel.amount)
                .font(.system(size: 35))
                .foregroundColor(Color.cyan)
                .multilineTextAlignment (.center)
                .keyboardType(.numberPad)
                . background{
                    Text(viewModel.amount == "" ? "EUR" : viewModel.amount)
                        .font(.system(size: 35))
                        .opacity(0)
                        .overlay(alignment: .trailing) {
                            Text("€")
                                .opacity (0.5)
                                .offset(x: 15, y: 0)
                        }
                }
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func descriptionText() -> some View {
        TextField("Description", text: $viewModel.desc)
            .padding()
            .textFieldStyle(.roundedBorder)
    }
    
    func detailDescriptionText() -> some View {
        TextField("Detail Description", text: $viewModel.detailDesc)
            .padding()
            .textFieldStyle(.roundedBorder)
    }
    
    @ViewBuilder
    func datePicker() -> some View {
        HStack{
            Text("Date:")
                .fontWeight(.semibold)
                .opacity(0.7)

            DatePicker.init("", selection: $viewModel.date, in: Date.distantPast...Date(), displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(.compact)
        }
    }
    
    @ViewBuilder
    func checkboxSelection() -> some View {
        HStack(spacing: 10){
            ForEach( [ExpenseType.income, ExpenseType.expense], id: \.self){type in
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                    if viewModel.type == type{
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor (Color.green)
                    }
                }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.type = type
                            }
                Text(type.rawValue)
            }
        }.padding(.vertical)

    }
    
    @ViewBuilder
    func saveButton() -> some View {
        Button {
            viewModel.saveData(env: env)
            env.dismiss()
        } label: {
            Text("Save")
        }
        .padding(.bottom, 12)
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.desc == ""  || viewModel.type == .all || viewModel.amount == "")
        .opacity(viewModel.desc == "" || viewModel.type == .all || viewModel.amount == "" ? 0.6 : 1)
    }
}
