//
//  User.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

public struct User: Codable {
    let firstName: String
    let lastName: String
    let address: Address
    let birthDate: Double
}

public struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
