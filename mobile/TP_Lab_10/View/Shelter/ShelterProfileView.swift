//
//  ShelterProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ShelterProfileView: View {
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color("lightPurple")
                    .ignoresSafeArea()
                
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        Image("shelter")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                        
                        ZStack(alignment: .topTrailing) {
                            VStack {
//                                ProfilePropertyView(title: "Name", value: .constant("Pupupu"), placeholder: "Add name", isEditing: false)
//                                
//                                ProfilePropertyView(title: "Bill", value: .constant("12-345-678"), placeholder: "Add name", isEditing: false)
//                                
//                                
//                                ProfilePropertyView(title: "Username", value: .constant("Oleg_228"), placeholder: "", isEditing: false)
//                                
//                                ProfilePropertyView(title: "Email", value: .constant("olega@gamil.com"), placeholder: "", isEditing: false)
//                                
//                                ProfilePropertyView(title: "Description", value: .constant("Super class"), placeholder: "", isEditing: false)
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding()
                            
                            
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
                            .padding(.top, 30)
                            .padding(.trailing, 30)
                            
                            
                        }
                        
                        
                        Spacer()
                        
                    }
                    .padding(.top)
                }
            }
            
        }
    }
}

#Preview {
    ShelterProfileView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
