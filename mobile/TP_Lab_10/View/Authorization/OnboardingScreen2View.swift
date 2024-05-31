//
//  OnboardingScreen2View.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct OnboardingScreen2View: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("lightGreen")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    
                    Image("onboardingPhoto2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 290)
                    
                    Text("Feature Frenzy")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("Interactive to-do lists with a personalized calendar for your pet")
                        .font(.system(size: 15))
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 270)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Image("threeDots2")
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
                        
                        NavigationLink(destination: OnboardingScreen3View()) {
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
    OnboardingScreen2View()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
