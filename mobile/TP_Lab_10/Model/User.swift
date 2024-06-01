//
//  User.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 30/05/2024.
//

import Foundation

struct User: Codable {
    var name: String = ""
    var surname: String = ""
    var username: String = " "
    var email: String = "example@gmail.com"
    var city: String = ""
    var image: Data = Data()
}
