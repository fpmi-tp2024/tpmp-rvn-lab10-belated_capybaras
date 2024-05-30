//
//  InputView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct InputView: View {
    
    var title: String
    @Binding var value: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.black)
            
            TextField(placeholder, text: $value)
                .padding(.vertical, 5)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    InputView(title: "Name", value: .constant("Dog"), placeholder: "Enter dog's name")
}
