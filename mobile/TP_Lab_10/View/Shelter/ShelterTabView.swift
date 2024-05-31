//
//  ShelterTabView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

enum Tab {
    case pets
    case profile
    case near
}

struct ShelterTabView: View {
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        
        // Apply the appearance to the tab bar
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    @State private var selectedTab: Tab = .pets
    
    var body: some View {
        
        NavigationView {
            
            TabView(selection: $selectedTab) {
                
                Spacer()
                
                ShelterDogsListView()
                    .tabItem {
                        Label("Pets", image: "dogIcon")
                    }
                    .tag(Tab.pets)
                
                ShelterProfileView()
                    .tabItem {
                        Label("Profile", image: "profileIcon")
                    }
                    .tag(Tab.profile)
                
                Spacer()
            }
            .accentColor(Color("darkPurple"))
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ShelterTabView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
