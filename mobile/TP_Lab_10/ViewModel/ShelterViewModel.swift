//
//  ShelterViewModel.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation
import Combine

class ShelterViewModel: ObservableObject {
    @Published var shelter: Shelter = Shelter()
    
    func updateShelterProfile() {
        guard let url = URL(string: "\(serverURL)/shelters/update") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(shelter)
            request.httpBody = jsonData
        } catch {
            print("Error encoding shelter data: \(error)")
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
                print("Successfully updated shelter profile")
                // Handle success
                if let data = data {
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
            case 400:
                print("Bad Request: The server could not understand the request due to invalid syntax.")
                self.handleErrorResponse(data: data)
            case 401:
                print("Unauthorized: The client must authenticate itself to get the requested response.")
                self.handleErrorResponse(data: data)
            case 403:
                print("Forbidden: The client does not have access rights to the content.")
                self.handleErrorResponse(data: data)
            case 404:
                print("Not Found: The server can not find the requested resource.")
                self.handleErrorResponse(data: data)
            case 500:
                print("Internal Server Error: The server has encountered a situation it doesn't know how to handle.")
                self.handleErrorResponse(data: data)
            default:
                print("Unexpected response from server: \(httpResponse.statusCode)")
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
