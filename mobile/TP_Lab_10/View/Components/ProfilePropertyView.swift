//
//  ProfilePropertyView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ProfilePropertyView: View {
    
    var title: String
    @Binding var value: String
    @Binding var isEditing: Bool
    var isDisabled: Bool
    var placeholder: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            HStack(alignment: .bottom) {
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
            }
            
            
            TextField(placeholder, text: $value)
                .padding(.vertical, 5)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .disabled(isDisabled || !isEditing)
            
            //                if isEditing {
            //                    if isDisabled {
            //                        Button {
            //                            isDisabled.toggle()
            //                        } label: {
            //                            Image(systemName: "square.and.pencil.circle.fill")
            //                                .imageScale(.large)
            //                                .font(.system(size: 22))
            //                                .foregroundStyle(Color("lightGreen"))
            //                        }
            //                        .frame(width: 20, height: 20)
            //
            //                    } else {
            //                        Button {
            //                            isDisabled.toggle()
            //                        } label: {
            //                            Image(systemName: "checkmark.circle.fill")
            //                                .imageScale(.large)
            //                                .font(.system(size: 22))
            //                                .foregroundStyle(Color("lightGreen"))
            //                        }
            //                        .frame(width: 20, height: 20)
            //
            //                    }
            //                }
            //            }
            //
            
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.black)
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    ProfilePropertyView(title: "Name", value: .constant("Olage"), isEditing: .constant(true), isDisabled: false, placeholder: "Enter name")
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
