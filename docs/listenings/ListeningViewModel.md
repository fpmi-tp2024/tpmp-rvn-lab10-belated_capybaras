
# Listening Swift Files

## AccountStatus.swift

```swift
//
//  AccountStatus.swift
//  TP_Lab_10
//

import Foundation

enum AccountStatus {
    case user
    case shelter
    case undefined
}

let serverURL = "https://7b2a-79-170-109-138.ngrok-free.app"
```
- ### AccountStatus определяет статус аккаунта.
```swift
enum AccountStatus {
    case user
    case shelter
    case undefined
}
```
- ### serverURL содержит URL сервера.
```swift
let serverURL = "https://7b2a-79-170-109-138.ngrok-free.app"
```

## AccountStatusViewModel.swift

```swift
//
//  AccountStatusViewModel.swift
//  TP_Lab_10
//

import Foundation

class AccountStatusViewModel: ObservableObject {
    
    @Published var accountStatus: AccountStatus = .user
}
```
- ### AccountStatusViewModel управляет состоянием аккаунта.
```swift
class AccountStatusViewModel: ObservableObject {
    
    @Published var accountStatus: AccountStatus = .user
}
```

## DogsViewModel.swift

```swift
//
//  DogsViewModel.swift
//  TP_Lab_10
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
    }
}
```
- ### DogsViewModel управляет данными о собаках и взаимодействует с сервером.
```swift
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
    }
}
```

## ShelterViewModel.swift

```swift
//
//  ShelterViewModel.swift
//  TP_Lab_10
//

import Foundation

class ShelterViewModel: ObservableObject {
    @Published var shelter: Shelter = Shelter()
}
```
- ### ShelterViewModel управляет данными о приюте.
```swift
class ShelterViewModel: ObservableObject {
    @Published var shelter: Shelter = Shelter()
}
```

