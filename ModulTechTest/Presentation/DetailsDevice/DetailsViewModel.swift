//
//  DetailsViewModel.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 28/1/2023.
//

import Foundation
import UIKit
import Combine

class DetailsViewModel {
    
    var passedDevice: Device
    @Published var sliderIntensityValue: Int?
    @Published var sliderPositionValue: Int?
    @Published var sliderTemperatureValue: Int?
    @Published var switchLightIsOn: Bool?
    @Published var switchHeaterIsOn: Bool?
    
    init(passedDevice: Device) {
        self.passedDevice = passedDevice
        self.sliderIntensityValue = passedDevice.intensity
        self.sliderPositionValue = passedDevice.position
        self.sliderTemperatureValue = passedDevice.temperature
        if let _ = switchLightIsOn {
            self.switchLightIsOn = passedDevice.mode == "ON"
        }
        if let _ = switchHeaterIsOn {
            self.switchHeaterIsOn = passedDevice.mode == "ON"
        }
    }
    
    func getProductType() -> ProductType {
        let product = ProductType(rawValue: passedDevice.productType)
        
        switch product {
            
        case .light:
            return .light
            
        case .rollerShutter:
            return .rollerShutter
            
        case .heater:
            return .heater
            
        default:
            return .light
        }
    }
    
    func getLabelDegree() -> String {
        switch getProductType() {
            
        case .heater:
            return "°"
            
        case .light:
            return "%"
            
        case .rollerShutter:
            return "%"
            
        }
    }
    
    func getDeviceName() -> String {
        switch getProductType() {
            
        case .light:
            return L10n.light
            
        case .heater:
            return L10n.heater
            
        case .rollerShutter:
            return L10n.rollerShutter
        }
    }
    
    func getDeviceMode() -> String {
        return passedDevice.mode ?? "ON"
    }
    
    func getImageOn() -> UIImage {
        return UIImage(named: getImageNameOn())!
    }
    
    func getImageOff() -> UIImage {
        return UIImage(named: getImageNameOff())!
    }
    
    func getImageRollerShutter() -> UIImage {
        return UIImage(named: ImagesNames.rolleShutter)!
    }
    
    func getImageNameOn() -> String {
        switch getProductType() {
            
        case .heater:
            return ImagesNames.heaterOn
            
        case .light:
            return ImagesNames.lightOn
            
        default:
            return ImagesNames.lightOn
            
        }
    }
    func getImageNameOff() -> String {
        switch getProductType() {
            
        case .heater:
            return ImagesNames.heaterOff
            
        case .light:
            return ImagesNames.lightOff
            
        default:
            return ImagesNames.lightOff
        }
    }
}
