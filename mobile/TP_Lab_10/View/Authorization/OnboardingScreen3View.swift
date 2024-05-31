//
//  OnboardingScreen3View.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct OnboardingScreen3View: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("lightGreen")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()

                    
                    Image("onboardingPhoto3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 347, height: 347)
                    
                    Text("Pet Memories")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("Capture unforgettable moments with your pet and share them with the community")
                        .font(.system(size: 15))
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 310)
                    
                    Spacer()
                        
                    
                    Image("threeDots3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 10)
                    
                    Spacer()
                        .frame(height: 45)
                    
                    NavigationLink(destination: RoleChoiceView()) {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 57)
                                .foregroundStyle(.white)
                            
                            Text("Get started!")
                                .font(.system(size: 22))
                                .foregroundStyle(.black)
        
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingScreen3View()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
