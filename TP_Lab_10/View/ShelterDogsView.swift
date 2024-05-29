//
//  ShelterDogsView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ShelterDogsView: View {
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
        
            ScrollView {
                
                HStack {
                    
                    Text("Our pets")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                LazyVGrid(columns: [ GridItem(), GridItem() ]) {
                    
                    ForEach(1...10, id: \.self) { index in
                        
                        Button {
                            
                        } label: {
                            ZStack(alignment: .topLeading) {
                                DogCardView()
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.black)
                                        .background {
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 30, height: 30)
                                        }
                                        .padding(.leading, 30)
                                        .padding(.top, 33)
                                }
                            }
                           
                        }
                        
                    }
                    
                }
                .padding(.horizontal, 10)
                
            }
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .imageScale(.large)
                    .font(.largeTitle)
                    .background {
                        Circle()
                            .fill(.black)
                            .frame(width: 50, height: 50)
                    }
                    .padding(.trailing, 40)
                    .padding(.bottom, 10)
            }
            
            
           
              
            
        }
        
        
    }
}

#Preview {
    ShelterDogsView()
}
