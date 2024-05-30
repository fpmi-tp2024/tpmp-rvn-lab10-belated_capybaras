//
//  UserProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var name: String = "Oleg"
    @State private var isEditing: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Color("lightPurple")
                .ignoresSafeArea()
            
            ScrollView {
                
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 20) {
                        
                        HStack {
                            
                            Spacer()
                            Image("user")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                                .overlay {
                                    Circle()
                                        .stroke(lineWidth: 3)
                                        .foregroundStyle(Color("lightGreen"))
                                        //.blur(radius: 3)
                                }
                        }
                        
                        
                        
                        ZStack(alignment: .topTrailing) {
                            
                            VStack(spacing: 18) {
                                ProfilePropertyView(title: "Name", value: .constant("Oleg"), placeholder: "Add name", isEditing: false)
                                
                                ProfilePropertyView(title: "Surname", value: .constant("Ivanov"), placeholder: "", isEditing: false)
                                
                                
                                ProfilePropertyView(title: "Username", value: .constant("Oleg_228"), placeholder: "", isEditing: false)
                                
                                ProfilePropertyView(title: "Email", value: .constant("olega@gamil.com"), placeholder: "", isEditing: false)
                                
                                ProfilePropertyView(title: "City", value: .constant("Gorod"), placeholder: "", isEditing: false)
                            }
                            .padding(.horizontal)
                            .padding(.top, 22)
                            .padding(.bottom, 30)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            
                
                            Button {
                                isEditing.toggle()
                            } label: {
                                if isEditing {
                                    Text("Edit")
                                        .font(.title3)
                                        .padding(.horizontal, 22)
                                        .padding(.vertical, 5)
                                        .background(Color("lightGreen"))
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                       
                                } else {
                                    Text("Done")
                                        .font(.title3)
                                        .padding(.horizontal, 22)
                                        .padding(.vertical, 5)
                                        .background(Color("lightGreen"))
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                    
                                    
                                    
                            }
                            .padding()
                            
                        }
                        
                    }
                    .padding()
                    .padding(.bottom, 20)
                    
                    Image("profileDog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .offset(x: 10, y: 90)
                }
            }
            
            
            
           
            
            
        }
    }
    
}

#Preview {
    UserProfileView()
}
