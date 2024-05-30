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
}

struct ShelterTabView: View {
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
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ShelterTabView()
}
