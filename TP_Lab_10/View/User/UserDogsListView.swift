//
//  DogsListView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserDogsListView: View {
    
    @EnvironmentObject var dogs: DogsViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("lightPurple")
                .ignoresSafeArea()
            
            ScrollView {
                
                HStack {
                    Text("Find a friend")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()
                    Image("pawLogoAndSign")
                }
                .padding(.horizontal)
                .padding(.top)
                
                LazyVGrid(columns: [ GridItem(), GridItem() ]) {
                    
                    ForEach(1...10, id: \.self) { index in
                        
                        NavigationLink(destination: DogProfileView(dog: Dog(id: 1, image: Data(UIImage(named: "dogCard")!.pngData()!), name: "Name", age: "Age", weight: "weight", shortDescription: "description", description: "Name is an outgoing and playful companion who enjoys spending time outdoors, whether it's chasing a ball at the park or going for a swim in the nearest pond. He's always up for an adventure and loves exploring new places, especially if it means making new friends along the way."))) {
                            DogCardView(dog: Dog(id: 1, image: Data(UIImage(named: "dogCard")!.pngData()!), name: "Name", age: "Age", weight: "", shortDescription: "description", description: ""))
                        }
                        
                    }
                    
                }
                .padding(.horizontal, 10)
                
            }
        }
        
        
        
    }
    
}

#Preview {
    UserDogsListView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
}
