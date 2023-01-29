//
//  Coordinator.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 28/1/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
