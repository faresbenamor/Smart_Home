//
//  HomeViewModel.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

class HomeViewModel: NSObject {
    
    func getDevices(_ completion: HomeResponseClosure?) {
        HomeManager.getDevices(completion: { success, devices in
            completion?(success, devices)
        })
    }
}
