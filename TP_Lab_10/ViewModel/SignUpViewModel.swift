import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var shouldNavigateToSignIn: Bool = false
    @Published var isAlert: Bool = false
    var type: String = "users"
    
    private var cancellables = Set<AnyCancellable>()
    
    func signUp() {
        let url = URL(string: "https://970c-185-64-104-88.ngrok-free.app/\(type)/register")!
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
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 200, 201:
                    print("sign up code 201")
                    DispatchQueue.main.async {
                        print("Success sign up async")
                        self.shouldNavigateToSignIn = true
                    }
                    return result.data
                case 400:
                    print("sign up code 400")
                    DispatchQueue.main.async {
                        print("sign up code 400 async")
                        self.isAlert = true
                    }
                    throw CustomError.badRequest
                case 401:
                    throw CustomError.unauthorized
                case 403:
                    throw CustomError.forbidden
                case 500:
                    print("sign up code 500")
                    DispatchQueue.main.async {
                        print("sign up code 500 async")
                        self.isAlert = true
                    }
                    throw CustomError.internalServerError
                default:
                    print("default sign in")
                    DispatchQueue.main.async {
                        print("default sign up code async")
                        self.isAlert = true
                    }
                    throw URLError(.unknown)
                }
            }
            .decode(type: SignUpResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    self.errorMessage = ""
                case .failure(let error):
                    self.errorMessage = self.handleError(error)
                }
            }, receiveValue: { response in
                print("Sign-up successful: \(response)")
                // Handle successful sign-up
                self.shouldNavigateToSignIn = true // Trigger navigation
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

enum CustomError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case internalServerError
    case networkError(Error) // New case for network errors
    case invalidResponse // New case for invalid response
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Invalid request. Please check your data."
        case .unauthorized:
            return "Unauthorized. Please check your credentials."
        case .forbidden:
            return "Forbidden. You do not have permission to perform this action."
        case .internalServerError:
            return "Internal Server Error. Please try again later."
        case .networkError(let error):
            return "Network error occurred: \(error.localizedDescription)" // Updated for network error
        case .invalidResponse:
            return "Invalid response received from server." // New localized description for invalid response
        }
    }
}

struct SignUpResponse: Decodable {
    let success: Bool
    let message: String
}
