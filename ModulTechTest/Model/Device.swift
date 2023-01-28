//
//  Device.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

public struct DeviceResponse: Codable {
    var devices: [Device]
    var user: User
}

public struct Device: Codable {
    var id: Int
    var deviceName: String
    var intensity: Int?
    var mode: String?
    var position: Int?
    var temperature: Int?
    var productType: String
}
