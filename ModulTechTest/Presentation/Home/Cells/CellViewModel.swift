//
//  CellViewModel.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 28/1/2023.
//

import Foundation
import UIKit

class CellViewModel {
    
    let intensity: Int?
    let mode: String?
    let position: Int?
    let temperature: Int?
    let productType: String
    
    init(intensity: Int?, mode: String?, position: Int?, temperature: Int?, productType: String) {
        self.intensity = intensity
        self.mode = mode
        self.position = position
        self.temperature = temperature
        self.productType = productType
    }
}
