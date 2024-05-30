//
//  ContentView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoaded = false
    var body: some View {
        
        Group {
            if isLoaded {
                OnboardingScreen1View()
            } else {
                LaunchScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isLoaded = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
