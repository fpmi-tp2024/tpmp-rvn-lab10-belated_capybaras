//
//  InputView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct AuthorizationInputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.bottom, -5)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
                    .foregroundStyle(.black)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    AuthorizationInputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
