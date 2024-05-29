//
//  DogProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct DogProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            VStack {
                Image("dogCard")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 30, height:UIScreen.main.bounds.width - 30)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                
                HStack {
                    Text("Name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    
                    HStack {
                        Text("Age")
                            .padding(.horizontal, 10)
                            .fontWeight(.medium)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .padding(10)
                            .background(.yellow.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 35))
                        
                        Text("Weight")
                            .padding(.horizontal, 10)
                            .fontWeight(.medium)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .padding(10)
                            .background(.purple.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 35))
                        
                        Text("Short description")
                            .padding(.horizontal, 10)
                            .fontWeight(.medium)
                            .font(.callout)
                            .foregroundStyle(.gray)
                            .padding(10)
                            .background(.pink.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 35))
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, -10)
                
                
                Text("Name is an outgoing and playful companion who enjoys spending time outdoors, whether it's chasing a ball at the park or going for a swim in the nearest pond. He's always up for an adventure and loves exploring new places, especially if it means making new friends along the way.")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Take for a walk")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 60)
                        .background(Color(red: 0.953, green: 0.588, blue: 0.561))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                .padding()
            }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                    }
                    .padding(.leading, 50)
                    .padding(.top, 33)
            }
        }
        
        
        
        
    }
    
}

#Preview {
    DogProfileView()
}
