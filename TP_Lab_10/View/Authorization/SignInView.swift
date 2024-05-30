//
//  SignInView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(spacing: 0) {
                    Color("darkPurple")
                        .opacity(0.85)
                        .frame(height: 255)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                
                
                   
                
                VStack(spacing: 20) {
                    
                    Image("dogSignIn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                   
                    AuthorizationInputView(text: $email, title: "Email", placeholder: "example@gmail.com")
                        .padding(.horizontal)
                    
                    AuthorizationInputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .padding(.horizontal)
                    
                    
                    NavigationLink(destination: ShelterTabView()) {
                        
                        HStack {
                            Text("SING IN")
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
                    
                    NavigationLink(destination: SignUpView()) {
                        
                        HStack(spacing: 3) {
                            Text("Don\'t have an account?")
                            
                            Text("Sign up")
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
    SignInView()
}
