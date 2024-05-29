//
//  UserSignUpView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserSignUpView: View {
    
    var body: some View {
        
        ZStack {
            
            Color(red: 0.988, green: 0.961, blue: 0.953)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Image("dogSignUp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
        
                
                InputView(title: "Username", placeholder: "Enter your name")
                    .padding(.horizontal)
                
                InputView(title: "Email", placeholder: "example@gmail.com")
                    .padding(.horizontal)
                
                InputView(title: "Password", placeholder: "Enter your password", isSecureField: true)
                    .padding(.horizontal)
                
                InputView(title: "Confirm password", placeholder: "Confirm your password",  isSecureField: true)
                    .padding(.horizontal)
                
                Button {
                   
                } label: {
                    
                    HStack {
                        Text("SING UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    
                }
                .background(Color(red: 0.467, green: 0.635, blue: 0.753))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 24)
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        
                        Text("Sign in")
                            .fontWeight(.bold)
                            
                    }
                    .font(.system(size: 15))
                    .foregroundStyle(Color(red: 0.169, green: 0.345, blue: 0.490))
                }
            }
        }
       
    }
    
}

#Preview {
    UserSignUpView()
}
