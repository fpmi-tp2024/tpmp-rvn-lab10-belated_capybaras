
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

## Dog.swift

```swift
//
//  Dog.swift
//  TP_Lab_10
//

import Foundation
import SwiftUI

struct Dog: Identifiable, Decodable {
    var id: Int
    var image: Data
    var name: String
    var age: String
    var weight: String
    var shortDescription: String
    var description: String
}
```
- ### Dog представляет структуру данных для собаки.
```swift
struct Dog: Identifiable, Decodable {
    var id: Int
    var image: Data
    var name: String
    var age: String
    var weight: String
    var shortDescription: String
    var description: String
}
```

## Shelter.swift

```swift
//
//  Shelter.swift
//  TP_Lab_10
//

import Foundation

struct Shelter: Decodable {
    var name: String = ""
    var bill: String = ""
    var username: String = ""
    var email: String = ""
    var description: String = ""
}
```
- ### Shelter представляет структуру данных для приюта.
```swift
struct Shelter: Decodable {
    var name: String = ""
    var bill: String = ""
    var username: String = ""
    var email: String = ""
    var description: String = ""
}
```

## User.swift

```swift
//
//  User.swift
//  TP_Lab_10
//

import Foundation

struct User: Decodable {
    var name: String = ""
    var surname: String = ""
    var username: String = ""
    var email: String = ""
    var city: String = ""
}
```
- ### User представляет структуру данных для пользователя.
```swift
struct User: Decodable {
    var name: String = ""
    var surname: String = ""
    var username: String = ""
    var email: String = ""
    var city: String = ""
}
```

