//
//  Shelter.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation

struct Shelter: Codable {
    var name: String = ""
    var bill: String = ""
    var username: String = ""
    var email: String = "admin"
    var description: String = ""
    var image: Data = Data()
}
