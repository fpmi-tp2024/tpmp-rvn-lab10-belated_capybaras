//
//  LaunchScreenView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops:
                [
                    .init(color: Color("lightPurple"), location: 0.0),
                    .init(color: Color("darkPurple"), location: 0.375),
                    .init(color: Color("darkPurple"), location: 0.625),
                    .init(color: Color("lightPurple"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .blur(radius: 125)
            .ignoresSafeArea()
            
            VStack {
                Image("pawLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 250, height: UIScreen.main.bounds.width - 250)
                
                Text("PetLink")
                    .font(.system(size: 45))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("lightGreen"))
            }
            
            
        }
    }
}

#Preview {
    LaunchScreenView()
}
