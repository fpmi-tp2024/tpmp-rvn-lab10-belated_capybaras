
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
        guard let url = URL(string: "\(serverURL)/dogs") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { CustomError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
                return Just(data).setFailureType(to: CustomError.self).eraseToAnyPublisher()
            }
            .decode(type: [Dog].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion { print("Error fetching data: \(error)") }
            }, receiveValue: { self.dogs = $0 })
            .store(in: &cancellables)
    }
    
    func pickUp(dogID: Int) {
        guard let url = URL(string: "\(serverURL)/dogs/take") else { return }
        
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
            .mapError { CustomError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
                return Just(data).setFailureType(to: CustomError.self).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion { print("Error during pick up: \(error)") }
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
        guard let url = URL(string: "\(serverURL)/dogs") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { CustomError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
                return Just(data).setFailureType(to: CustomError.self).eraseToAnyPublisher()
            }
            .decode(type: [Dog].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion { print("Error fetching data: \(error)") }
            }, receiveValue: { self.dogs = $0 })
            .store(in: &cancellables)
    }
    
    func pickUp(dogID: Int) {
        guard let url = URL(string: "\(serverURL)/dogs/take") else { return }
        
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
            .mapError { CustomError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, CustomError> in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    return Fail(error: CustomError.badRequest).eraseToAnyPublisher()
                }
                return Just(data).setFailureType(to: CustomError.self).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion { print("Error during pick up: \(error)") }
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

## LaunchScreenView.swift

```swift
//
//  LaunchScreenView.swift
//  TP_Lab_10
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops:
                [
                    .init(color: Color("lightPurple"), location: 0.0),
                    .init(color: Color("darkPurple"), location: 0.375),
                    .init(color: Color("darkPurple"), location: 0.625),
                    .init(color: Color("lightPurple"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .blur(radius: 125)
            .ignoresSafeArea()
            
            VStack {
                Image("pawLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 250, height: UIScreen.main.bounds.width - 250)
                
                Text("PetLink")
                    .font(.system(size: 45))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("lightGreen"))
            }
        }
    }
}
```
- ### LaunchScreenView отображает экран загрузки.
```swift
struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops:
                [
                    .init(color: Color("lightPurple"), location: 0.0),
                    .init(color: Color("darkPurple"), location: 0.375),
                    .init(color: Color("darkPurple"), location: 0.625),
                    .init(color: Color("lightPurple"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .blur(radius: 125)
            .ignoresSafeArea()
            
            VStack {
                Image("pawLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 250, height: UIScreen.main.bounds.width - 250)
                
                Text("PetLink")
                    .font(.system(size: 45))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("lightGreen"))
            }
        }
    }
}
```

## OnboardingScreen1View.swift

```swift
//
//  OnboardingScreen1View.swift
//  TP_Lab_10
//

import SwiftUI

struct OnboardingScreen1View: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("lightGreen").ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Image("onboardingPhoto1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 310)
                    Text("Get Inspired")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("From tracking your pet's health to connecting with other pet owners, we've got you covered")
                        .font(.system(size: 15))
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 310)
                    Spacer().frame(height: 20)
                    Image("threeDots1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 10)
                    Spacer()
                    HStack {
                        NavigationLink(destination: RoleChoiceView()) {
                            Text("Skip").font(.system(size: 20)).foregroundStyle(.white)
                        }
                        Spacer()
                        NavigationLink(destination: OnboardingScreen2View()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        }
                    }.padding(30)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
```
- ### OnboardingScreen1View отображает первый экран онбординга.
```swift
struct OnboardingScreen1View: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("lightGreen").ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Image("onboardingPhoto1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 310)
                    Text("Get Inspired")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("From tracking your pet's health to connecting with other pet owners, we've got you covered")
                        .font(.system(size: 15))
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 310)
                    Spacer().frame(height: 20)
                    Image("threeDots1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 10)
                    Spacer()
                    HStack {
                        NavigationLink(destination: RoleChoiceView()) {
                            Text("Skip").font(.system(size: 20)).foregroundStyle(.white)
                        }
                        Spacer()
                        NavigationLink(destination: OnboardingScreen2View()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        }
                    }.padding(30)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
```

## OnboardingScreen2View.swift

```swift
//
//  OnboardingScreen2View.swift
//  TP_Lab_10
//

import SwiftUI

struct OnboardingScreen2View: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("lightGreen").ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Image("onboardingPhoto2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 290)
                    Text("Feature Frenzy")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("Interactive to-do lists with a personalized calendar for your pet")
                        .font(.system(size: 15))
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 270)
                    Spacer().frame(height: 20)
                    Image("threeDots2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 10)
                    Spacer()
                    HStack {
                        NavigationLink(destination: RoleChoiceView()) {
                            Text("Skip").font(.system(size: 20)).foregroundStyle(.white)
                        }
                        Spacer()
                        NavigationLink(destination: OnboardingScreen3View()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        }
                    }.padding(30)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
```
- ### OnboardingScreen2View отображает второй экран онбординга.
```swift

                    NavigationLink(destination: RoleChoiceView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 57)
                                .foregroundStyle(.white)
                            Text("Get started!")
                                .font(.system(size: 22))
                                .foregroundStyle(.black)
                        }
                    }
                    Spacer().frame(height: 10)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
```

## RoleChoiceView.swift

```swift
//
//  RoleChoiceView.swift
//  TP_Lab_10
//

import SwiftUI

struct RoleChoiceView: View {
    @State private var navigateToSignUp = false
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color("darkPurple").opacity(0.85).frame(height: 365)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                VStack {
                    VStack {
                        Image("dogGreeting").resizable().scaledToFit().frame(width: 300, height: 300)
                        Spacer()
                        Text("We're thrilled to have you here! Whether you're looking to adopt a furry friend, volunteer your time, or simply stay updated on our latest events and success stories")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 30)
                            .padding(.top)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    VStack {
                        Text("Choose who you are...").font(.title3).foregroundStyle(.black)
                        Button {
                            accountStatusVM.accountStatus = .user
                            navigateToSignUp = true
                        } label: {
                            Text("User")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 60)
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        Button {
                            accountStatusVM.accountStatus = .shelter
                            navigateToSignUp = true
                        } label: {
                            Text("Shelter")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 60)
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
            }
        }.navigationBarBackButtonHidden(true)
    }
}
```
- ### RoleChoiceView отображает выбор роли пользователя.
```swift
struct RoleChoiceView: View {
    @State private var navigateToSignUp = false
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color("darkPurple").opacity(0.85).frame(height: 365)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                VStack {
                    VStack {
                        Image("dogGreeting").resizable().scaledToFit().frame(width: 300, height: 300)
                        Spacer()
                        Text("We're thrilled to have you here! Whether you're looking to adopt a furry friend, volunteer your time, or simply stay updated on our latest events and success stories")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 30)
                            .padding(.top)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    VStack {
                        Text("Choose who you are...").font(.title3).foregroundStyle(.black)
                        Button {
                            accountStatusVM.accountStatus = .user
                            navigateToSignUp = true
                        } label: {
                            Text("User")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 60)
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        Button {
                            accountStatusVM.accountStatus = .shelter
                            navigateToSignUp = true
                        } label: {
                            Text("Shelter")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 60)
                                .background(Color("lightGreen"))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
            }
        }.navigationBarBackButtonHidden(true)
    }
}
```

## SignInView.swift

```swift
//
//  SignInView.swift
//  TP_Lab_10
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var signInData: SignInViewModel
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color("darkPurple").opacity(0.85).frame(height: 255)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image("dogSignIn").resizable().scaledToFit().frame(width: 200, height: 200).padding()
                    AuthorizationInputView(text: $signInData.email, title: "Email", placeholder: "example@gmail.com").padding(.horizontal)
                    AuthorizationInputView(text: $signInData.password, title: "Password", placeholder: "Enter your password", isSecureField: true).padding(.horizontal)
                    Button(action: { signInData.signIn(urlStr: urlStr) }) {
                        if signInData.isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).frame(maxWidth: .infinity).padding().background(Color("lightGreen")).clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            HStack {
                                Text("SING IN").fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        }
                    }
                    .background(Color("lightGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 24)
                    .disabled(signInData.isLoading)
                    Spacer()
                    NavigationLink(destination: SignUpView()) {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign up").fontWeight(.bold)
                        }
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                    }
                }
            }
            .navigationDestination(isPresented: $signInData.isSignedIn) {
                if accountStatusVM.accountStatus == .user {
                    UserTabView()
                } else if accountStatusVM.accountStatus == .shelter {
                    ShelterTabView()
                }
            }
            .alert(isPresented: $signInData.isAlert) {
                Alert(title: Text("Ups"), message: Text("This user doesn't exist"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var type: String {
        if accountStatusVM.accountStatus == .user { return "users" }
        else if accountStatusVM.accountStatus == .shelter { return "users" }
        else { return "undefined" }
    }
    
    private var urlStr: String {
        return "\(serverURL)/\(type)/login"
    }
}
```
- ### SignInView отображает экран входа пользователя.
```swift
struct SignInView: View {
    @EnvironmentObject var signInData: SignInViewModel
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color("darkPurple").opacity(0.85).frame(height: 255)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image("dogSignIn").resizable().scaledToFit().frame(width: 200, height: 200).padding()
                    AuthorizationInputView(text: $signInData.email, title: "Email", placeholder: "example@gmail.com").padding(.horizontal)
                    AuthorizationInputView(text: $signInData.password, title: "Password", placeholder: "Enter your password", isSecureField: true).padding(.horizontal)
                    Button(action: { signInData.signIn(urlStr: urlStr) }) {
                        if signInData.isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).frame(maxWidth: .infinity).padding().background(Color("lightGreen")).clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            HStack {
                                Text("SING IN").fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        }
                    }
                    .background(Color("lightGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 24)
                    .disabled(signInData.isLoading)
                    Spacer()
                    NavigationLink(destination: SignUpView()) {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign up").fontWeight(.bold)
                        }
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                    }
                }
            }
            .navigationDestination(isPresented: $signInData.isSignedIn) {
                if accountStatusVM.accountStatus == .user {
                    UserTabView()
                } else if accountStatusVM.accountStatus == .shelter {
                    ShelterTabView()
                }
            }
            .alert(isPresented: $signInData.isAlert) {
                Alert(title: Text("Ups"), message: Text("This user doesn't exist"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var type: String {
        if accountStatusVM.accountStatus == .user { return "users" }
        else if accountStatusVM.accountStatus == .shelter { return "users" }
        else { return "undefined" }
    }
    
    private var urlStr: String {
        return "\(serverURL)/\(type)/login"
    }
}
```

## SignUpView.swift

```swift
//
//  SignUpView.swift
//  TP_Lab_10
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var signUpData: SignUpViewModel
    @EnvironmentObject var accountStatusVM: AccountStatusViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color("darkPurple").opacity(0.85).frame(height: 265)
                    Color("lightPurple")
                }
                .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image("dogSignUp").resizable().scaledToFit().frame(width: 200, height: 200).padding()
                    AuthorizationInputView(text: $signUpData.username, title: "Username", placeholder: "Enter your name").padding(.horizontal)
                    AuthorizationInputView(text: $signUpData.email, title: "Email", placeholder: "example@gmail.com").padding(.horizontal)
                    AuthorizationInputView(text: $signUpData.password, title: "Password", placeholder: "Enter your password", isSecureField: true).padding(.horizontal)
                    Button(action: { signUpData.signUp(urlStr: urlStr) }) {
                        if signUpData.isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).frame(maxWidth: .infinity).padding().background(Color("lightGreen")).clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            HStack {
                                Text("SIGN UP").fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        }
                    }
                    .background(Color("lightGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 24)
                    .disabled(signUpData.isLoading)
                    Spacer()
                    Button { signUpData.shouldNavigateToSignIn = true } label: {
                        HStack(spacing: 3) {
                            Text("Already have an account?")
                            Text("Sign in").fontWeight(.bold)
                        }
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                    }
                }
            }
            .navigationDestination(isPresented: $signUpData.shouldNavigateToSignIn) {
                SignInView()
            }
            .alert(isPresented: $signUpData.isAlert) {
                Alert(title: Text("Ups"), message: Text("Can't sign up user"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var type: String {
        if accountStatusVM.accountStatus == .user { return "users" }
        else if accountStatusVM.accountStatus == .shelter { return "users" }
        else { return "undefined" }
    }
    
    private var urlStr: String {
        return "\(serverURL)/\(type)/register
