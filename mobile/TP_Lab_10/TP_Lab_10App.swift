//
//  TP_Lab_10App.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

@main
struct TP_Lab_10App: App {
    
    @StateObject private var signUpViewModel = SignUpViewModel()
    @StateObject private var signInViewModel = SignInViewModel()
    @StateObject private var dogsViewModel = DogsViewModel()
    @StateObject private var accountStatus = AccountStatusViewModel()
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var shelterViewModel = ShelterViewModel()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(signUpViewModel)
                .environmentObject(signInViewModel)
                .environmentObject(dogsViewModel)
                .environmentObject(accountStatus)
                .environmentObject(userViewModel)
                .environmentObject(shelterViewModel)
        }
    }
}
