//
//  RegistrationView.swift
//  Tracker
//
//  Created by M.Ali SEN
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @State private var userIsLoggedIn = false
    @State private var showErrorAlert = false
    @StateObject private var viewModel = AccountViewModel()
    @State private var showSuccessAlert = false

    var dismiss: () -> ()

    var body: some View {
        NavigationStack{
            if userIsLoggedIn {
                ContentView()
            } else
            {
                registrationContent()
            }
        }
        .onAppear{
            self.userIsLoggedIn = false
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.registrationError ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: viewModel.registrationError) { error in
            showErrorAlert = error != nil
        }
        
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Success!"),
                message: Text(viewModel.successMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: viewModel.successMessage) { message in
            showSuccessAlert = viewModel.successMessage != nil
        }
    }
}
extension RegistrationView {
    
    @ViewBuilder
    func registrationContent() -> some View {
        ZStack {
            VStack(spacing: 10){
                title()
                Spacer()
                emailField()
                passwordField()
                registerButton()
                Spacer()
            }.padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func title() -> some View {
        HStack{
            Text("Registration")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 15)
            Spacer()
            Button(action: dismiss) {
                      Text("Cancel")
                  }
            .padding(.top, 15)
        }
    }
    
    @ViewBuilder
    func emailField() -> some View {
        TextField("Email", text: $viewModel.email)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    func passwordField() -> some View {
        SecureField("Password", text: $viewModel.password)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func registerButton() -> some View {
        Button {
            viewModel.register()
        } label: {
            Text("Register")
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 12)
    }
}
