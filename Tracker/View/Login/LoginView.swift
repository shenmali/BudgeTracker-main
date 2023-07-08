//
//  LoginScreen.swift
//  Tracker
//
//

import SwiftUI
import Firebase
import ModalView

struct LoginView: View {
    @StateObject private var loginViewModel = AccountViewModel()
    @State private var showErrorAlert = false
    @State private var rememberMe = false

    var body: some View {
        NavigationStack{
            ModalPresenter{
                if loginViewModel.userID == "" {
                    content()
                } else {
                    ContentView()
                }
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(loginViewModel.loginError ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: loginViewModel.loginError) { error in
            showErrorAlert = error != nil
        }
    }
}

extension LoginView {
    
    @ViewBuilder
    func content() -> some View {
        ZStack {
            VStack(spacing: 10){
                HStack {
                    welcomeText()
                }
                Spacer()
                helpText()
                emailInput()
                passwordInput()
                rememberMeToggle()
                loginButton()
                
                ModalLink {dismiss in
                    RegistrationView.init(dismiss: dismiss)
                } label: {
                    Text("Don't have an account? Create one!")
                        .font(.footnote)
                        .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }.padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func welcomeText() -> some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
    }
    
    @ViewBuilder
    func helpText() -> some View {
        Text("Please login to access your budget tracker")
            .font(.footnote)
            .fontWeight(.bold)
            .padding(.bottom, 15)
    }
    
    @ViewBuilder
    func emailInput() -> some View {
        TextField("Email", text: $loginViewModel.email)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func passwordInput() -> some View {
        SecureField("Password", text: $loginViewModel.password)
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
            .padding([.horizontal], 24)
    }
    
    @ViewBuilder
    func rememberMeToggle() -> some View {
        Toggle(isOn: $rememberMe) {
            Text("Remember Me")
        }
        .toggleStyle(SwitchToggleStyle(tint: .blue))
        .padding(.vertical, 5)
    }
    
    @ViewBuilder
    func loginButton() -> some View {
        Button {
            loginViewModel.login()
        } label: {
            Text("Firebase login")
        }
        .buttonStyle(.borderedProminent)
        .padding(.vertical, 12)
    }
}
