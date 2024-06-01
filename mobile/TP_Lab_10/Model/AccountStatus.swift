//
//  AccountStatus.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation

enum AccountStatus {
    case user
    case shelter
    case undefined
}

let serverURL = "https://118a-194-99-105-90.ngrok-free.app"
var isFirstTimeOnProfileView = true
var isFirstTimeOnShleterProfileVew = true
var isFirstTimeOnShelterListView = true
