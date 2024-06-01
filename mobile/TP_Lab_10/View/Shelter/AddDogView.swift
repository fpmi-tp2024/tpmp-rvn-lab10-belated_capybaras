//
//  AddDogView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import SwiftUI

struct AddDogView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var dogsVM: DogsViewModel
    @EnvironmentObject var shelterVM: ShelterViewModel
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var shortDescription: String = ""
    @State private var description: String = ""
    @State private var image: Data = Data()
    
    @State private var isShowingImagePicker = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .topLeading) {
                
                Color("lightPurple")
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        ZStack(alignment: .bottomTrailing) {
                            
                            if !image.isEmpty && UIImage(data: image) != nil {
                                Image(uiImage: UIImage(data: image)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 30, height:UIScreen.main.bounds.width - 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 35))
                            } else {
                                Image("addPhoto")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 30, height:UIScreen.main.bounds.width - 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 35))
                                
                            }
                            
                            Button(action: {
                                isShowingImagePicker = true
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundStyle(.white)
                                    .background {
                                        Circle()
                                            .fill(Color("lightGreen"))
                                            .frame(width: 40, height: 40)
                                    }
                                    .padding(.trailing, 22)
                                    .padding(.bottom, 22)
                            }
                            
                        }
                        
                        VStack {
                            InputView(title: "Name", value: $name, placeholder: "Enter dog's name")
                            
                            InputView(title: "Age", value: $age, placeholder: "Enter dog's age")
                            
                            InputView(title: "Weight", value: $weight, placeholder: "Enter dog's weight")
                            
                            InputView(title: "Short description", value: $shortDescription, placeholder: "Enter short description")
                            
                            InputView(title: "Description", value: $description, placeholder: "Enter description")
                        }
                        .padding()
                        .padding(.vertical)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        
                        
                        
                        Button {
                            if !name.isEmpty && !age.isEmpty && !weight.isEmpty && !shortDescription.isEmpty && !description.isEmpty && !image.isEmpty {
                                // Create a new Dog instance
                                let newDog = Dog(id: 1, image: image, name: name, age: age, weight: weight, shortDescription: shortDescription, description: description)
                                
                                // Send POST request to the server
                                dogsVM.addDog(dog: newDog, shelterEmail: shelterVM.shelter.email)
                                
                                // Dismiss the view
                                dismiss()
                            }
                        } label: {
                            HStack {
                                Text("CONFIRM")
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color("lightGreen"))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding(.top, 10)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                }
                
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .background {
                            Circle()
                                .fill(Color("lightGreen"))
                                .frame(width: 40, height: 40)
                        }
                        .padding(.leading, 40)
                        .padding(.top, 35)
                }
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $image, isPresented: $isShowingImagePicker)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: Data
        @Binding var isPresented: Bool
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            let parent: ImagePicker
            
            init(parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let image = info[.originalImage] as? UIImage {
                    parent.selectedImage = image.pngData() ?? UIImage(named: "user")!.pngData()!
                }
                parent.isPresented = false
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.isPresented = false
            }
        }
    }
}

#Preview {
    AddDogView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
