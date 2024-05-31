//
//  DogCardView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct DogCardView: View {
    
    var dog: Dog
    
    var body: some View {
        
        VStack {
            
            Image(uiImage: UIImage(data: dog.image)!)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
            Spacer()
                .frame(height: 5)
            
            VStack {
                HStack {
                    
                    Text("\(dog.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text("\(dog.age)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
                
                HStack {
                    Text("\(dog.shortDescription)")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 11)
            .padding(.bottom, 20)
            .padding(.top, 10)
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(width: 170)
        .shadow(radius: 8, y: 10)
        .padding()
    }
    
}

#Preview {
    DogCardView(dog: Dog(id: 1, image: Data(UIImage(named: "dogCard")!.pngData()!), name: "Name", age: "Age", weight: "", shortDescription: "description", description: ""))
}
