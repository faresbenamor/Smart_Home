//
//  Device.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

public struct HomeResponse: Codable {
    let devices: [Device]
    let user: User
}

public struct Device: Codable {
    let id: Int
    let deviceName: String
    var intensity: Int?
    var mode: String?
    var position: Int?
    var temperature: Int?
    let productType: String
}
