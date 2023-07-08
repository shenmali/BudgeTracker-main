import SwiftUI

struct SavingCard: View {
    var saving: Saving
    @EnvironmentObject var viewModel: SavingsViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(viewModel.convertNumberToPrice(value: saving.amount))
                .font(.headline)
                .foregroundColor(.green)
            
            Spacer()
            
            Text(saving.date.formatted(date: .numeric, time: .omitted))
                .font(.caption)
            
            Button(action: {
                deleteSaving()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.linearGradient(colors: [Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                .opacity(colorScheme == .light ? 0.1 : 0.2)
        )
        .padding(.horizontal)
    }
}

extension SavingCard {
    func deleteSaving() {
       let index = viewModel.savings.firstIndex(where: { $0.id == saving.id })
       guard let savingIndex = index else { return }
       
       viewModel.savings.remove(at: savingIndex)
       
       let savingRef = viewModel.db.collection("savings").document(saving.id)
       savingRef.delete { error in
           if let error = error {
               print("Error deleting saving document: \(error)")
               viewModel.savings.insert(saving, at: savingIndex)
           }
       }
   }
}
