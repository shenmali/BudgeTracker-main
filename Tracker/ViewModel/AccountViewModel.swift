//
//  LoginViewModel.swift
//  Tracker
//
//  Created by M.Ali SEN on 20.12.2022..
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI

class AccountViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @AppStorage("uid") var userID = ""
    @AppStorage("rememberedUsername") var rememberedUsername = ""
    @Published var loginError: String?
    @Published var registrationError: String?
    @Published var successMessage: String?

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.loginError = error?.localizedDescription ?? ""
            } else {
                self.loginError = nil
            }
            if let result = result {
                withAnimation {
                    self.userID = result.user.uid
                    self.rememberedUsername = self.email // Kullanıcı adını hatırlanan kullanıcı adına atama
                }
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            if error != nil {
                print("Registration error:", error?.localizedDescription ?? "")
                self.registrationError = error?.localizedDescription ?? ""
            } else {
                self.registrationError = nil
                self.successMessage = "Successfully registered! You may now login."
            }
        }
    }
}
