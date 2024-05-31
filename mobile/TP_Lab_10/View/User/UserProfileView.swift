//
//  UserProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var isEditing: Bool = false
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Color("lightPurple")
                .ignoresSafeArea()
            
            ScrollView {
                
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 20) {
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                isShowingImagePicker = true
                            }) {
                                if let selectedImage = selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 200, height: 200)
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 3)
                                                .foregroundStyle(Color("lightGreen"))
                                        }
                                } else {
                                    Image(systemName: "photo.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .foregroundStyle(Color("darkPurple"))
                                        .frame(width: 200, height: 200)
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 3)
                                                .foregroundStyle(Color("lightGreen"))
                                        }
                                }
                            }
                        }
                        
                        ZStack(alignment: .topTrailing) {
                            
                            VStack(spacing: 18) {
                                ProfilePropertyView(title: "Name", value: $userVM.user.name, isEditing: $isEditing, isDisabled: false, placeholder: "Add name")
                                
                                ProfilePropertyView(title: "Surname", value: $userVM.user.surname, isEditing: $isEditing, isDisabled: false, placeholder: "Add surname")
                                
                                
                                ProfilePropertyView(title: "Username", value: $userVM.user.username, isEditing: $isEditing, isDisabled: true, placeholder: "username")
                                
                                ProfilePropertyView(title: "Email", value: $userVM.user.email, isEditing: $isEditing, isDisabled: true, placeholder: "email")
                                
                                ProfilePropertyView(title: "City", value: $userVM.user.city, isEditing: $isEditing, isDisabled: false, placeholder: "Add city")
                            }
                            .padding(.horizontal)
                            .padding(.top, 22)
                            .padding(.bottom, 30)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            
                            
                            Button {
                                isEditing.toggle()
                            } label: {
                                if isEditing {
                                    Text("Done")
                                        .font(.title3)
                                        .padding(.horizontal, 22)
                                        .padding(.vertical, 5)
                                        .background(Color("lightGreen"))
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    
                                } else {
                                    Text("Edit")
                                        .font(.title3)
                                        .padding(.horizontal, 22)
                                        .padding(.vertical, 5)
                                        .background(Color("lightGreen"))
                                        .foregroundStyle(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                
                                
                                
                            }
                            .padding()
                            
                        }
                        
                    }
                    .padding()
                    .padding(.bottom, 20)
                    
                    Image("profileDog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .offset(x: 10, y: 90)
                }
            }
            
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
        
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
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
                parent.selectedImage = image
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

#Preview {
    UserProfileView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
