//
//  RoleChoiceView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct RoleChoiceView: View {
    
    @State private var navigateToSignUp = false
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                VStack(spacing: 0) {
                    
                    Color("darkPurple")
                        .opacity(0.85)
                        .frame(height: 365)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                
                
                
                VStack {
                    
                    VStack {
                        
                        Image("dogGreeting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        
                        Spacer()
                        
                        Text("We're thrilled to have you here! Whether you're looking to adopt a furry friend, volunteer your time, or simply stay updated on our latest events and success stories")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 30)
                            .padding(.top)
                        
                        Spacer()
                        
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("Choose who you are...")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        
                        Button {
                            accountStatusVM.accountStatus = .user
                            navigateToSignUp = true
                        } label: {
                            Text("User")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 60)
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        
                        
                        Button {
                            accountStatusVM.accountStatus = .shelter
                            navigateToSignUp = true
                        } label: {
                            
                            Text("Shelter")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 60)
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RoleChoiceView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
