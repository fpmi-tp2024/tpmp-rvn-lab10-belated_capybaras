//
//  User.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import Foundation

struct User: Decodable {
    var name: String
    var surname: String
    let username: String
    let email: String
    var city: String
}
