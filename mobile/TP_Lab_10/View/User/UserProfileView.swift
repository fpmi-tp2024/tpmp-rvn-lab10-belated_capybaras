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
                                if !userVM.user.image.isEmpty {
                                    Image(uiImage: UIImage(data: userVM.user.image)!)
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
                                if isEditing {
                                    userVM.updateUserProfile() // Call the method to send the POST request
                                }
                                isEditing.toggle()
                            } label: {
                                Text(isEditing ? "Done" : "Edit")
                                    .font(.title3)
                                    .padding(.horizontal, 22)
                                    .padding(.vertical, 5)
                                    .background(Color("lightGreen"))
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
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
        .onAppear {
            //isFetchingUser = true
            if isFirstTimeOnProfileView {
                fetchUser(email: userVM.user.email)
                isFirstTimeOnProfileView = false
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $userVM.user.image, isPresented: $isShowingImagePicker)
                .onDisappear {
                    userVM.updateUserProfile()
                }
        }
        
    }
    
    func fetchUser(email: String) {
        let urlStr = "\(serverURL)/users/info"
            
            guard let url = URL(string: urlStr) else {
                print("Invalid URL.")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = ["email": email]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            } catch {
                print("Failed to encode request body.")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                switch response.statusCode {
                case 200...299:
                    // Success, handle response data
                    do {
                        let decodedUser = try JSONDecoder().decode(User.self, from: data)
                        DispatchQueue.main.async {
                            userVM.user = decodedUser
                        }
                    } catch {
                        print("Error decoding user data: \(error)")
                    }
                case 400:
                    print("Bad Request: \(response.statusCode)")
                    // Handle bad request error
                case 401:
                    print("Unauthorized: \(response.statusCode)")
                    // Handle unauthorized error
                case 403:
                    print("Forbidden: \(response.statusCode)")
                    // Handle forbidden error
                case 404:
                    print("Not Found: \(response.statusCode)")
                    // Handle not found error
                case 500...599:
                    print("Server Error: \(response.statusCode)")
                    // Handle server error
                default:
                    print("Unhandled status code: \(response.statusCode)")
                }
            }.resume()
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
    UserProfileView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
