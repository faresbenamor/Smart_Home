//
//  AppCoordinator.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 28/1/2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var window: UIWindow

    init(navigationController: UINavigationController, window: UIWindow) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let homeViewController = HomeViewController(viewModel: HomeViewModel.init())
        navigationController.viewControllers = [homeViewController]
        window.rootViewController = navigationController
        
        homeViewController.callback = { [weak self] (device) in
           guard let `self` = self else { return }
            self.showDetailsViewController(passedDevice: device, homeVC: homeViewController)
        }
    }
    
    private func showDetailsViewController(passedDevice: Device, homeVC: HomeViewController) {
        let detailsViewController = DetailsDeviceViewController(viewModel: DetailsViewModel.init(passedDevice: passedDevice))
        //detailsViewController.passedDevice = passedDevice
        detailsViewController.delegate = homeVC
        self.showViewController(detailsViewController)
    }

    private func showViewController(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
