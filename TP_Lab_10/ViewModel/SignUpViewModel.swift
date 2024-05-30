//
//  SignUpViewModel.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func signUp() {
        guard validateFields() else { return }
        
        let url = URL(string: "https://your-backend.com/api/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "email": email, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            errorMessage = "Failed to encode request body."
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: SignUpResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Sign-up failed: \(error.localizedDescription)"
                }
            }, receiveValue: { response in
                print("Sign-up successful: \(response)")
                // Handle successful sign-up, e.g., navigate to the next screen
            })
            .store(in: &self.cancellables)
    }
    
    private func validateFields() -> Bool {
        if username.isEmpty {
            errorMessage = "Username is required"
            return false
        }
        if email.isEmpty || !isValidEmail(email) {
            errorMessage = "Valid email is required"
            return false
        }
        if password.isEmpty {
            errorMessage = "Password is required"
            return false
        }
        if confirmPassword.isEmpty || confirmPassword != password {
            errorMessage = "Passwords do not match"
            return false
        }
        errorMessage = ""
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct SignUpResponse: Decodable {
    let success: Bool
    let message: String
}
