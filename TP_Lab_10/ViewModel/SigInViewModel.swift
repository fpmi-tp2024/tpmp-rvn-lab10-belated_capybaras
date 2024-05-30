//
//  SigInViewModel.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isSignedIn: Bool = false
    @Published var isAlert: Bool = false
    var type: String = "users"
    
    private var cancellables = Set<AnyCancellable>()
    
    func signIn() {
        let url = URL(string: "https://970c-185-64-104-88.ngrok-free.app/\(type)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "password": password]
        
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
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 200, 201:
                    print("sign in code 201")
                    DispatchQueue.main.async {
                        print("Success sign in async")
                        self.isSignedIn = true
                    }
                    return result.data
                case 400:
                    throw CustomError.badRequest
                case 401:
                    print("sign in 401")
                    DispatchQueue.main.async {
                        print("sign in 401 async")
                        self.isAlert = true
                    }
                    throw CustomError.unauthorized
                case 403:
                    throw CustomError.forbidden
                case 500:
                    print("sign in 500")
                    DispatchQueue.main.async {
                        print("sign in 500 async")
                        self.isAlert = true
                    }
                    throw CustomError.internalServerError
                default:
                    print("default sign in")
                    DispatchQueue.main.async {
                        print("default sign in async")
                        self.isAlert = true
                    }
                    throw URLError(.unknown)
                }
            }
            .decode(type: SignInResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    self.errorMessage = ""
                case .failure(let error):
                    self.errorMessage = self.handleError(error)
                }
            }, receiveValue: { response in
                print("Sign-in successful: \(response)")
                // Handle successful sign-in
                self.isSignedIn = true // Trigger navigation or state change
            })
            .store(in: &self.cancellables)
    }
    
    private func handleError(_ error: Error) -> String {
        if let customError = error as? CustomError {
            return customError.localizedDescription
        } else if let urlError = error as? URLError {
            return urlError.localizedDescription
        } else {
            return "Unknown error occurred."
        }
    }
}

struct SignInResponse: Decodable {
    let success: Bool
    let message: String
}


