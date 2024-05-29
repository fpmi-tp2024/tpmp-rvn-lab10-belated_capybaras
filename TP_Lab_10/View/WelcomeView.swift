//
//  WelcomeView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        
        ZStack {
            
            Color(red: 0.988, green: 0.961, blue: 0.953)
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                    Text("Welcome!")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                    
                    Image("dogGreeting")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Text("We're thrilled to have you here! Whether you're looking to adopt a furry friend, volunteer your time, or simply stay updated on our latest events and success stories")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                        .padding(.horizontal, 30)
                        .padding(.top)
                        
                    
                }
                .padding(.vertical)
                    
                Spacer()
                
                VStack {
                    
                    Text("Choose who you are...")
                        .font(.title3)
                        .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                    
                    Button {
                         
                    } label: {
                        
                        Text("User")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                            .frame(width: 300, height: 60)
                            .background(Color(red: 0.945, green: 0.807, blue: 0.780))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    
                    Button {
                         
                    } label: {
                        Text("Shelter")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                            .frame(width: 300, height: 60)
                            .background(Color(red: 0.945, green: 0.807, blue: 0.780))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
