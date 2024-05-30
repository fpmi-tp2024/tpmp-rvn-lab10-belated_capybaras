//
//  UserTabView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct UserTabView: View {
    
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
                
                UserProfileView()
                    .tabItem {
                        Label("Profile", image: "profileIcon")
                    }
                    .tag(Tab.profile)
                
                Spacer()
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    UserTabView()
}
