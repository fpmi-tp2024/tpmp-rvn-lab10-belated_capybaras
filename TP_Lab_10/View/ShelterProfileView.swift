//
//  ShelterProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ShelterProfileView: View {
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                
                Image("shelter")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                
                ProfilePropertyView(title: "Name", value: .constant("Pupupu"), placeholder: .constant("Add name"), isEditing: true)
                
                ProfilePropertyView(title: "Bill", value: .constant("12-345-678"), placeholder: .constant("Add name"), isEditing: true)
                
                
                ProfilePropertyView(title: "Username", value: .constant("Oleg_228"), placeholder: .constant(""), isEditing: false)
                
                ProfilePropertyView(title: "Email", value: .constant("olega@gamil.com"), placeholder: .constant(""), isEditing: false)
                
                ProfilePropertyView(title: "Description", value: .constant("Super class"), placeholder: .constant(""), isEditing: true)
                    
                
                Spacer()
                
            }
            .padding(.top)
        }
    }
}

#Preview {
    ShelterProfileView()
}
