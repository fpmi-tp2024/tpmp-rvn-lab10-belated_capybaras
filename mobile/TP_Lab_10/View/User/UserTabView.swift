//
//  UserTabView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct UserTabView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
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
                
                UserDogsListView()
                    .tabItem {
                        Label("Pets", image: "dogIcon")
                    }
                    .tag(Tab.pets)
                
                MapView()
                    .tabItem {
                        Label("Near", image: "globeIcon")
                    }
                    .tag(Tab.near)
                
                
                UserProfileView()
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
    UserTabView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
