//
//  AddDogView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct AddDogView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .topLeading) {
                
                Color("lightPurple")
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        ZStack(alignment: .bottomTrailing) {
                            
                            Image("dogCard")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 30, height:UIScreen.main.bounds.width - 30)
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundStyle(.white)
                                    .background {
                                        Circle()
                                            .fill(Color("lightGreen"))
                                            .frame(width: 40, height: 40)
                                    }
                                    .padding(.trailing, 22)
                                    .padding(.bottom, 22)
                            }
                            
                        }
                        
                        VStack {
                            InputView(title: "Name", value: .constant(""), placeholder: "Enter dog's name")
                            
                            InputView(title: "Age", value: .constant(""), placeholder: "Enter dog's age")
                                
                            InputView(title: "Weight", value: .constant(""), placeholder: "Enter dog's weight")
                                
                            InputView(title: "Short description", value: .constant(""), placeholder: "Enter short description")
                            
                            InputView(title: "Description", value: .constant(""), placeholder: "Enter description")
                        }
                        .padding()
                        .padding(.vertical)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                
                        
                        
                        NavigationLink(destination: ShelterDogsListView()) {
                            
                            HStack {
                                Text("CONFIRM")
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            
                        }
                        .background(Color("lightGreen"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(.top, 10)
                        
                    }
                    .padding(.horizontal)
                    
                }
                
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .background {
                            Circle()
                                .fill(Color("lightGreen"))
                                .frame(width: 40, height: 40)
                        }
                        .padding(.leading, 40)
                        .padding(.top, 35)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddDogView()
}
