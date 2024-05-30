//
//  ShelterDogsView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ShelterDogsListView: View {
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .bottomTrailing) {
                
                Color("lightPurple")
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    HStack {
                        
                        Text("Our pets")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image("pawLogoAndSign")
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    LazyVGrid(columns: [ GridItem(), GridItem() ]) {
                        
                        ForEach(1...10, id: \.self) { index in
                            
                            Button {
                                
                            } label: {
                                ZStack(alignment: .topLeading) {
                                    
                                    DogCardView(dog: Dog(image: UIImage(named: "dogCard")!, name: "Name", age: "Age", weight: "", shortDescription: "description", description: ""))
                                    
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
                
                
                NavigationLink(destination: AddDogView()) {
                    
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .imageScale(.large)
                        .font(.largeTitle)
                        .background {
                            Circle()
                                .fill(Color("lightGreen"))
                                .frame(width: 50, height: 50)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)
                    
                    
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ShelterDogsListView()
}
