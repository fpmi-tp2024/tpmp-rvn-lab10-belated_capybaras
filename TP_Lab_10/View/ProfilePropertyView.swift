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
    @Binding var placeholder: String
    @State private var isDisabled: Bool = true
    var isEditing: Bool
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            HStack(alignment: .bottom) {
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))

            }
           
            HStack {
                TextField(placeholder, text: $value)
                    .padding(.vertical, 5)
                    .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .disabled(isDisabled)
                
                if isEditing {
                    if isDisabled {
                        Button {
                            isDisabled.toggle()
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                                .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                        }
                        .frame(width: 20, height: 20)
                        
                    } else {
                        Button {
                            isDisabled.toggle()
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .imageScale(.large)
                                .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
                        }
                        .frame(width: 20, height: 20)
                        
                    }
                }
            }
            
            
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(red: 0.545, green: 0.333, blue: 0.278))
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    ProfilePropertyView(title: "Name", value: .constant("Oleg"), placeholder: .constant("Enter name"), isEditing: true)
}
