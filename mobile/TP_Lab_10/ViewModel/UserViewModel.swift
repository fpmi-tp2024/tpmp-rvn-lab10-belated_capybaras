//
//  UserViewModel.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User = User()
}
