//
//  UIViewController.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

extension UIViewController {
        
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showActivityIndicator(activityIndicator: UIActivityIndicatorView, onView: UIView) {
        onView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.color = .white
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }
}
