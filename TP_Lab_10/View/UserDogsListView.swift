//
//  DogsListView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserDogsListView: View {
    
    var body: some View {
        
        ScrollView {
            
            HStack {
                Text("Find a friend")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            
            LazyVGrid(columns: [ GridItem(), GridItem() ]) {
                
                ForEach(1...10, id: \.self) { index in
                    
                    Button {
                        
                    } label: {
                        DogCardView()
                    }
                    
                }
                
            }
            .padding(.horizontal, 10)
            
        }
        
    }
    
}

#Preview {
    UserDogsListView()
}
