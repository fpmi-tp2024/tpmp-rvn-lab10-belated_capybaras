//
//  UserSignUpView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct SignUpView: View {
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                VStack(spacing: 0) {
                    Color("darkPurple")
                        .opacity(0.85)
                        .frame(height: 265)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Image("dogSignUp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
            
                    
                    AuthorizationInputView(title: "Username", placeholder: "Enter your name")
                        .padding(.horizontal)
                    
                    AuthorizationInputView(title: "Email", placeholder: "example@gmail.com")
                        .padding(.horizontal)
                    
                    AuthorizationInputView(title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .padding(.horizontal)
                    
                    AuthorizationInputView(title: "Confirm password", placeholder: "Confirm your password",  isSecureField: true)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: SignInView()) {
                        HStack {
                            Text("SING UP")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color("lightGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    NavigationLink(destination: SignInView()) {
                        
                        HStack(spacing: 3) {
                            Text("Already have an account?")
                            
                            Text("Sign in")
                                .fontWeight(.bold)
                                
                        }
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    SignUpView()
}
