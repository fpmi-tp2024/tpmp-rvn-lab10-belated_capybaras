//
//  DogsListView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserDogsListView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("lightPurple")
                .ignoresSafeArea()
            
            ScrollView {
                
                HStack {
                    Text("Find a friend")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()
                    Image("pawLogoAndSign")
                }
                .padding(.horizontal)
                .padding(.top)
                
                LazyVGrid(columns: [ GridItem(), GridItem() ]) {
                    
                    ForEach(1...10, id: \.self) { index in
                        
                        NavigationLink(destination: DogProfileView()) {
                            DogCardView()
                        }
                        
                    }
                    
                }
                .padding(.horizontal, 10)
                
            }
        }
        
        
        
    }
    
}

#Preview {
    UserDogsListView()
}
