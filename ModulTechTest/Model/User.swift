//
//  User.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

public struct User: Codable {
    var firstName: String
    var lastName: String
    var address: Address
    var birthDate: Double
}

public struct Address: Codable {
    var city: String
    var postalCode: Int
    var street: String
    var streetCode: String
    var country: String
}
