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
        guard let url = URL(string: "https://your-api-url.com/dogs") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .mapError { error in
                    // Map URLError to a custom error for better error handling
                    CustomError.networkError(error)
                }
                .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return Fail(error: CustomError.invalidResponse).eraseToAnyPublisher()
                    }
                    
                    switch httpResponse.statusCode {
                    case 200...299:
                        // Success status code range, proceed with decoding
                        return Just(data)
                            .setFailureType(to: CustomError.self)
                            .eraseToAnyPublisher()
                    case 400:
                        return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                    case 401:
                        return Fail(error: CustomError.unauthorized).eraseToAnyPublisher()
                    case 403:
                        return Fail(error: CustomError.forbidden).eraseToAnyPublisher()
                    case 404:
                        return Fail(error: CustomError.notFound).eraseToAnyPublisher()
                    default:
                        // Handle other status codes as needed
                        return Fail(error: CustomError.unknown).eraseToAnyPublisher()
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
}
