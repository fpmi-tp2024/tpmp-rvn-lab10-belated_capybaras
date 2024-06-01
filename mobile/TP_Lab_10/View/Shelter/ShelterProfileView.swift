//
//  ShelterProfileView.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 29/05/2024.
//

import SwiftUI

struct ShelterProfileView: View {
    
    @State private var isEditing: Bool = false
    @EnvironmentObject var shelterVM: ShelterViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color("lightPurple")
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            if !shelterVM.shelter.image.isEmpty && UIImage(data: shelterVM.shelter.image) != nil {
                                Image(uiImage: UIImage(data: shelterVM.shelter.image)!)
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
                        
                        ZStack(alignment: .topTrailing) {
                            VStack {

                                ProfilePropertyView(title: "Name", value: $shelterVM.shelter.name, isEditing: $isEditing, isDisabled: false, placeholder: "Add name")
                                
                                ProfilePropertyView(title: "Bill", value: $shelterVM.shelter.bill, isEditing: $isEditing, isDisabled: false, placeholder: "Add bill")
                                
                                
                                ProfilePropertyView(title: "Username", value: $shelterVM.shelter.username, isEditing: $isEditing, isDisabled: true, placeholder: "username")
                                
                                ProfilePropertyView(title: "Email", value: $shelterVM.shelter.email, isEditing: $isEditing, isDisabled: true, placeholder: "email")
                                
                                ProfilePropertyView(title: "Description", value: $shelterVM.shelter.description, isEditing: $isEditing, isDisabled: false, placeholder: "Add description")
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding()
                            
                            
                            Button {
                                if isEditing {
                                    shelterVM.updateShelterProfile()
                                }
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
                            .padding(.top, 30)
                            .padding(.trailing, 30)
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                if isFirstTimeOnShleterProfileVew {
                    fetchShelter(email: shelterVM.shelter.email)
                    isFirstTimeOnShleterProfileVew = false
                }
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $shelterVM.shelter.image, isPresented: $isShowingImagePicker)
                    .onDisappear {
                        shelterVM.updateShelterProfile()
                    }
            }
        }
    }
    
    func fetchShelter(email: String) {
        let urlStr = "\(serverURL)/shelters/info"
            
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
                        let decodedShelter = try JSONDecoder().decode(Shelter.self, from: data)
                        DispatchQueue.main.async {
                            // Update shelter information in your ViewModel or wherever you store shelter data
                            shelterVM.shelter = decodedShelter
                        }
                    } catch {
                        print("Error decoding shelter data: \(error)")
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
                    parent.selectedImage = image.pngData() ?? UIImage(named: "shelter")!.pngData()!
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
    ShelterProfileView()
        .environmentObject(SignUpViewModel())
        .environmentObject(SignInViewModel())
        .environmentObject(DogsViewModel())
        .environmentObject(AccountStatusViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(ShelterViewModel())
}
