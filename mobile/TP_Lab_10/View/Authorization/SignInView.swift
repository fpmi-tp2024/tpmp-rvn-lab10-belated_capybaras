//
//  SignInView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var signInData: SignInViewModel
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        
        NavigationStack {
            
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
                   
                    AuthorizationInputView(text: $signInData.email, title: "Email", placeholder: "example@gmail.com")
                        .padding(.horizontal)
                    
                    AuthorizationInputView(text: $signInData.password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .padding(.horizontal)
                    
                    
//                    NavigationLink(destination: ShelterTabView()) {
//                        
//                        HStack {
//                            Text("SING IN")
//                                .fontWeight(.semibold)
//                            Image(systemName: "arrow.right")
//                        }
//                        .foregroundStyle(.white)
//                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
//                        
//                    }
//                    .background(Color("lightGreen"))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.top, 24)
                    
                    Button(action: {
                        signInData.signIn(urlStr: urlStr)
                    }) {
                        if signInData.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            HStack {
                                Text("SING IN")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        }
                    }
                    .background(Color("lightGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 24)
                    .disabled(signInData.isLoading)
                    
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
            .navigationDestination(isPresented: $signInData.isSignedIn) {
                if accountStatusVM.accountStatus == .user {
                    UserTabView()
                } else if accountStatusVM.accountStatus == .shelter {
                    ShelterTabView()
                }
            }
            .alert(isPresented: $signInData.isAlert) {
                Alert(title: Text("Ups"), message: Text("This user doesn't exist"), dismissButton: .default(Text("OK")))
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var type: String {
        if accountStatusVM.accountStatus == .user {
            return "users"
        } else if accountStatusVM.accountStatus == .shelter {
            return "users"
        } else {
            return "undefined"
        }
    }
    
    private var urlStr: String {
        return "\(serverURL)/\(type)/login"
    }
    
}

#Preview {
    SignInView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
