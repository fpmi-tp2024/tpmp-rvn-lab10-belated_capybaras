//
//  OnboardingScreen1View.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct OnboardingScreen1View: View {
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color("lightGreen")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Image("onboardingPhoto1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 310)
                    
                    Text("Get Inspired")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("From tracking your pet's health to connecting with other pet owners, we've got you covered")
                        .font(.system(size: 15))
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 310)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Image("threeDots1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 10)
                    
                    Spacer()
                    
                    
                    HStack {
                        
                        NavigationLink(destination: RoleChoiceView()) {
                            Text("Skip")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: OnboardingScreen2View()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        }
                        
                    }
                    .padding(30)

                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingScreen1View()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
