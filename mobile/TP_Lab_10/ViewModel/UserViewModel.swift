//
//  UserViewModel.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User = User()
    
    func updateUserProfile() {
        
        guard let url = URL(string: "\(serverURL)/users/update") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user data: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making network request: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response from server")
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                print("Successfully updated user profile")
                // Handle success
                if let data = data {
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
            case 400:
                print("Bad Request: The server could not understand the request due to invalid syntax.")
                // Handle bad request
                self.handleErrorResponse(data: data)
            case 401:
                print("Unauthorized: The client must authenticate itself to get the requested response.")
                // Handle unauthorized
                self.handleErrorResponse(data: data)
            case 403:
                print("Forbidden: The client does not have access rights to the content.")
                // Handle forbidden
                self.handleErrorResponse(data: data)
            case 404:
                print("Not Found: The server can not find the requested resource.")
                // Handle not found
                self.handleErrorResponse(data: data)
            case 500:
                print("Internal Server Error: The server has encountered a situation it doesn't know how to handle.")
                // Handle internal server error
                self.handleErrorResponse(data: data)
            default:
                print("Unexpected response from server: \(httpResponse.statusCode)")
                // Handle unexpected response
                self.handleErrorResponse(data: data)
            }
        }
        
        task.resume()
    }
    
    private func handleErrorResponse(data: Data?) {
        guard let data = data else { return }
        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
            print("Error message: \(errorResponse.message)")
        } else {
            print("Failed to decode error response")
        }
    }
    
    struct ErrorResponse: Decodable {
        let message: String
    }
}
