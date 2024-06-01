//
//  DogsViewModel.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation
import Combine

class DogsViewModel: ObservableObject {
    
    @Published var dogs: [Dog] = []
    @Published var shelterDogs: [Dog] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        guard let url = URL(string: "\(serverURL)/dogs") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                CustomError.networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: CustomError.invalidResponse).eraseToAnyPublisher()
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    print("200-299 in downloading images for user")
                    return Just(data)
                        .setFailureType(to: CustomError.self)
                        .eraseToAnyPublisher()
                case 400:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                case 401:
                    return Fail(error: CustomError.unauthorized).eraseToAnyPublisher()
                case 403:
                    return Fail(error: CustomError.forbidden).eraseToAnyPublisher()
                default:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
            }
            .decode(type: [Dog].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Data fetching completed for user")
                case .failure(let error):
                    print("Error fetching data user: \(error)")
                }
            }, receiveValue: { dogs in
                self.dogs = dogs
            })
            .store(in: &cancellables)
    }
    
    func fetchDataForShelter(email: String) {
        guard let url = URL(string: "\(serverURL)/shelters/dogs") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Failed to encode request body: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                CustomError.networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: CustomError.invalidResponse).eraseToAnyPublisher()
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    print("200-299 in downloading images for shelter")
                    return Just(data)
                        .setFailureType(to: CustomError.self)
                        .eraseToAnyPublisher()
                case 400:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                case 401:
                    return Fail(error: CustomError.unauthorized).eraseToAnyPublisher()
                case 403:
                    return Fail(error: CustomError.forbidden).eraseToAnyPublisher()
                default:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
            }
            .decode(type: [Dog].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Data fetching completed for shelter")
                case .failure(let error):
                    print("Error fetching data shelter: \(error)")
                }
            }, receiveValue: { dogs in
                self.shelterDogs = dogs
            })
            .store(in: &cancellables)
    }
    
    func pickUp(dogID: Int) {
        
        guard let url = URL(string: "\(serverURL)/dogs/take") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["id": dogID]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Failed to encode request body: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                CustomError.networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: CustomError.invalidResponse).eraseToAnyPublisher()
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    return Just(data)
                        .setFailureType(to: CustomError.self)
                        .eraseToAnyPublisher()
                case 400:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                case 401:
                    return Fail(error: CustomError.unauthorized).eraseToAnyPublisher()
                case 403:
                    return Fail(error: CustomError.forbidden).eraseToAnyPublisher()
                default:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Pick up completed")
                case .failure(let error):
                    print("Error during pick up: \(error)")
                }
            }, receiveValue: { _ in
                self.dogs.removeAll { $0.id == dogID }
            })
            .store(in: &cancellables)
        
        //        guard let url = URL(string: "https://52aa-185-64-104-96.ngrok-free.app/dogs/take") else {
        //            print("Invalid URL")
        //            return
        //        }
        //
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "POST"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        //        let body: [String: Int] = ["id": dogID]
        //
        //        do {
        //            request.httpBody = try JSONEncoder().encode(body)
        //        } catch {
        //            print("Failed to encode request body: \(error)")
        //            return
        //        }
        //
        //        URLSession.shared.dataTaskPublisher(for: request)
        //            .mapError { error in
        //                CustomError.networkError(error)
        //            }
        //            .flatMap { data, response -> AnyPublisher<Void, CustomError> in
        //                guard let httpResponse = response as? HTTPURLResponse else {
        //                    return Fail(error: CustomError.invalidResponse).eraseToAnyPublisher()
        //                }
        //
        //                switch httpResponse.statusCode {
        //                case 200...299:
        //                    print("Dog picked up successfully")
        //                    if let index = self.dogs.firstIndex(where: { $0.id == dogID }) {
        //                        self.dogs.remove(at: index)
        //                    }
        //                    return Just(()).setFailureType(to: CustomError.self).eraseToAnyPublisher()
        //                case 400:
        //                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
        //                case 401:
        //                    return Fail(error: CustomError.unauthorized).eraseToAnyPublisher()
        //                case 403:
        //                    return Fail(error: CustomError.forbidden).eraseToAnyPublisher()
        //                default:
        //                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
        //                }
        //            }
        //            .sink(receiveCompletion: { completion in
        //                switch completion {
        //                case .finished:
        //                    print("Pickup request completed")
        //                case .failure(let error):
        //                    print("Error picking up dog: \(error)")
        //                }
        //            }, receiveValue: { _ in
        //                // Do nothing
        //            })
        //            .store(in: &cancellables)
    }
    
    func pickUpShelter(dogID: Int) {
        guard let url = URL(string: "\(serverURL)/dogs/take") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["id": dogID]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Failed to encode request body: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                CustomError.networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: CustomError.invalidResponse).eraseToAnyPublisher()
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    return Just(data)
                        .setFailureType(to: CustomError.self)
                        .eraseToAnyPublisher()
                case 400:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                case 401:
                    return Fail(error: CustomError.unauthorized).eraseToAnyPublisher()
                case 403:
                    return Fail(error: CustomError.forbidden).eraseToAnyPublisher()
                default:
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Pick up completed")
                case .failure(let error):
                    print("Error during pick up: \(error)")
                }
            }, receiveValue: { _ in
                self.shelterDogs.removeAll { $0.id == dogID }
            })
            .store(in: &cancellables)
    }
    
    func addDog(dog: Dog, shelterEmail: String) {
        guard let url = URL(string: "\(serverURL)/dogs/new") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create a dictionary that combines the dog and shelterEmail
        let dogDict: [String: Any] = [
            "name": dog.name,
            "age": dog.age,
            "weight": dog.weight,
            "shortDescription": dog.shortDescription,
            "description": dog.description,
            "image": dog.image.base64EncodedString(),
            "shelterEmail": shelterEmail
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dogDict, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error encoding dog data: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                print("Successfully added dog")
                // Handle the response data if needed
                if let data = data {
                    do {
                        let addedDog = try JSONDecoder().decode(Dog.self, from: data)
                        DispatchQueue.main.async {
                            self.shelterDogs.append(addedDog)
                        }
                    } catch {
                        print("Error decoding dog data: \(error)")
                    }
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
        }.resume()
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


