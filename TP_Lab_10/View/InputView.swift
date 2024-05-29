//
//  InputView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct InputView: View {
    /*@Binding*/ @State var text: String = ""
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color(red: 0.169, green: 0.345, blue: 0.490))
                .fontWeight(.bold)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.bottom, -5)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
                    .foregroundStyle(Color(red: 0.169, green: 0.345, blue: 0.490))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
                    .foregroundStyle(Color(red: 0.169, green: 0.345, blue: 0.490))
            }
        }
    }
}

#Preview {
    InputView(text: "", title: "Email Address", placeholder: "name@example.com")
}
