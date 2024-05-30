//
//  Dog.swift
//  TP_Lab_10
//
//  Created by Даниил Соловьев on 31/05/2024.
//

import Foundation
import SwiftUI

struct Dog: Identifiable {
    let id = UUID()
    var image: UIImage
    var name: String
    var age: String
    var weight: String
    var shortDescription: String
    var description: String
}
