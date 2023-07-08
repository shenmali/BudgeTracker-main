import SwiftUI

struct NewSavingView: View {
    @EnvironmentObject var viewModel: SavingsViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment (\.self) var env
    
    var body: some View {
        VStack {
            VStack {
                addSavingsText()
                amountTextField()
                dateSelection()
                Spacer()
                saveInputButton()
            }
        }
    }
}

extension NewSavingView {
    
    @ViewBuilder
    func addSavingsText() -> some View {
        Text("Add Savings")
            .font(.title2)
            .fontWeight(.semibold)
            .opacity(0.5)
            .padding(.top, 15)
    }
    
    @ViewBuilder
    func amountTextField() -> some View {
        if let symbol = viewModel.convertNumberToPrice(value: 0).first {
            TextField("0", text: $viewModel.amount)
                .font(.system(size: 35))
                .foregroundColor(Color.cyan)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .background {
                    Text(viewModel.amount == "" ? "EUR" : viewModel.amount)
                        .font(.system(size: 35))
                        .opacity(0)
                        .overlay(alignment: .trailing) {
                            Text("€")
                                .opacity(0.5)
                                .offset(x: 15, y: 0)
                        }
                }
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func dateSelection() -> some View {
        HStack {
            Text("Date:")
                .fontWeight(.semibold)
                .opacity(0.7)
            
            DatePicker("", selection: $viewModel.date, in: Date.distantPast...Date(), displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(.compact)
        }
        
    }
    
    @ViewBuilder
    func saveInputButton() -> some View {
        Button(action: {
            viewModel.saveData(env: env)
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Save")
        }
        .padding(.bottom, 12)
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.amount.isEmpty)
        .opacity(viewModel.amount.isEmpty ? 0.6 : 1)
        
    }
}
