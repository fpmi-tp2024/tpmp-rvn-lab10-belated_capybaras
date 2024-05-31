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
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        guard let url = URL(string: "https://52aa-185-64-104-96.ngrok-free.app/dogs") else {
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
                    print("200-299 in downloading images")
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
                    print("Data fetching completed")
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { dogs in
                self.dogs = dogs
            })
            .store(in: &cancellables)
    }
    
    func pickUp(dogID: Int) {
        
        guard let url = URL(string: "https://52aa-185-64-104-96.ngrok-free.app/dogs/take") else {
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
}
