//
//  UserProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var name: String = "Oleg"
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                
                Image("user")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                
                
                ProfilePropertyView(title: "Name", value: .constant("Oleg"), placeholder: .constant("Add name"), isEditing: true)
                
                ProfilePropertyView(title: "Surname", value: .constant("Ivanov"), placeholder: .constant(""), isEditing: true)
                
                
                ProfilePropertyView(title: "Username", value: .constant("Oleg_228"), placeholder: .constant(""), isEditing: false)
                
                ProfilePropertyView(title: "Email", value: .constant("olega@gamil.com"), placeholder: .constant(""), isEditing: false)
                
                ProfilePropertyView(title: "City", value: .constant("Gorod"), placeholder: .constant(""), isEditing: true)
                
                Spacer()
                
            }
            .padding(.top)
        }
    }
    
}

#Preview {
    UserProfileView()
}
