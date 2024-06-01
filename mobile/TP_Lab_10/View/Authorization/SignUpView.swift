//
//  UserSignUpView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct SignUpView: View {
    
    //@State private var isNavigatingToSignIn = false
    @EnvironmentObject var signUpData: SignUpViewModel
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        
        NavigationStack {
            
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
                    
                    AuthorizationInputView(text: $signUpData.username, title: "Username", placeholder: "Enter your name")
                        .padding(.horizontal)
                    
                    AuthorizationInputView(text: $signUpData.email, title: "Email", placeholder: "example@gmail.com")
                        .padding(.horizontal)
                    
                    AuthorizationInputView(text: $signUpData.password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        .padding(.horizontal)
                    
//                    AuthorizationInputView(text: $signUpData.confirmPassword, title: "Confirm password", placeholder: "Confirm your password",  isSecureField: true)
//                        .padding(.horizontal)
//                    
                    //                     NavigationLink(destination: SignInView()) {
                    //                     HStack {
                    //                     Text("SING UP")
                    //                     .fontWeight(.semibold)
                    //                     Image(systemName: "arrow.right")
                    //                     }
                    //                     .foregroundStyle(.white)
                    //                     .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    //                     }
                    //                     .background(Color("lightGreen"))
                    //                     .clipShape(RoundedRectangle(cornerRadius: 10))
                    //                     .padding(.top, 24)
                    
                    Button(action: {
                        signUpData.signUp(urlStr: urlStr)
                    }) {
                        if signUpData.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            HStack {
                                Text("SIGN UP")
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
                    .disabled(signUpData.isLoading)
                    
                    Spacer()
                    
                    Button {
                        signUpData.shouldNavigateToSignIn = true
                    } label: {
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
            .navigationDestination(isPresented: $signUpData.shouldNavigateToSignIn) {
                    SignInView()
            }
            .alert(isPresented: $signUpData.isAlert) {
                Alert(title: Text("Ups"), message: Text("Can't sign up user"), dismissButton: .default(Text("OK")))
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var type: String {
        if accountStatusVM.accountStatus == .user {
            return "users"
        } else if accountStatusVM.accountStatus == .shelter {
            return "shelters"
        } else {
            return "undefined"
        }
    }
    
    private var urlStr: String {
        return "\(serverURL)/\(type)/register"
    }
    
}

#Preview {
    SignUpView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
