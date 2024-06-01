//
//  ShelterDogsView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ShelterDogsListView: View {
    
    @EnvironmentObject var dogsVM: DogsViewModel
    @EnvironmentObject var shelterVM: ShelterViewModel
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .bottomTrailing) {
                
                Color("lightPurple")
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    HStack {
                        
                        Text("Our pets")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image("pawLogoAndSign")
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    LazyVGrid(columns: [ GridItem(), GridItem() ]) {
                        
                        ForEach(dogsVM.shelterDogs, id: \.id) { dog in
                            
                            ZStack(alignment: .topLeading) {
                                
                                DogCardView(dog: dog)
                                
                                Button {
                                    dogsVM.pickUpShelter(dogID: dog.id)
                                    
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.black)
                                        .background {
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 30, height: 30)
                                        }
                                        .padding(.leading, 30)
                                        .padding(.top, 33)
                                }
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal, 10)
                    
                }
                
                
                NavigationLink(destination: AddDogView()) {
                    
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .imageScale(.large)
                        .font(.largeTitle)
                        .background {
                            Circle()
                                .fill(Color("lightGreen"))
                                .frame(width: 50, height: 50)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)
                    
                    
                }
                
                
            }
            .onAppear {
                if isFirstTimeOnShelterListView {
                    dogsVM.fetchDataForShelter(email: shelterVM.shelter.email)
                    isFirstTimeOnShelterListView = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ShelterDogsListView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
