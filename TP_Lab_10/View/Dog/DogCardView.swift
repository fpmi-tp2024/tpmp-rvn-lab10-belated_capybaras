//
//  DogCardView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct DogCardView: View {
    
    var body: some View {
        
        VStack {
            
            Image("dogCard")
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
            Spacer()
                .frame(height: 5)
            
            VStack {
                HStack {
                    
                    Text("Name")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text("age")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
                
                HStack {
                    Text("description")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 11)
            .padding(.bottom, 20)
            .padding(.top, 10)
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(width: 170)
        .shadow(radius: 8, y: 10)
        .padding()
    }
    
}

#Preview {
    DogCardView()
}
