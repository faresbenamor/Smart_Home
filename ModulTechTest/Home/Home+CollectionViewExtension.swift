//
//  Home+CollectionViewExtension.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devicesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DevicesCollectionViewCell.identifier, for: indexPath) as! DevicesCollectionViewCell
        
        let device = devicesArray[indexPath.item]
        let product = ProductType(rawValue: device.productType)
        
        // Mode for Light or Heater
        if let mode = device.mode {
            cell.modeLabel.text = "\(L10n.mode): \(mode)"
            cell.modeLabel.isHidden = false
        }
        else {
            cell.modeLabel.isHidden = true
        }
        
        // Intensity for Light
        if let intensity = device.intensity {
            cell.intensityLabel.text = "\(L10n.intensity): \(intensity.description)%"
            cell.intensityLabel.isHidden = false
        }
        else {
            cell.intensityLabel.isHidden = true
        }
        
        // Position for RullerShutter
        if let position = device.position {
            if position == 0 {
                cell.positionLabel.text = L10n.closed
            }
            else if position == 100 {
                cell.positionLabel.text = L10n.opened
            }
            else {
                cell.positionLabel.text = "\(L10n.openedAt) \(position.description)%"
            }
            cell.positionLabel.isHidden = false
        }
        else {
            cell.positionLabel.isHidden = true
        }
        
        // Temperature for Heater
        if let temperature = device.temperature {
            
            cell.temperatureLabel.text = "Temp: \(temperature.description)°"
            cell.temperatureLabel.isHidden = false
        }
        else {
            cell.temperatureLabel.isHidden = true
        }

        // Image Device
        switch product {

        case .rollerShutter:
            cell.imageDevice.image = UIImage(named: "DeviceRollerShutterIcon")

        case .heater:
            cell.imageDevice.image = device.mode == "ON" ? UIImage(named: "DeviceHeaterOnIcon") : UIImage(named: "DeviceHeaterOffIcon")

        case .light:
            cell.imageDevice.image = device.mode == "ON" ? UIImage(named: "DeviceLightOnIcon") : UIImage(named: "DeviceLightOffIcon")

        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsDeviceViewController()
        detailsVC.passedDevice = devicesArray[indexPath.item]
        detailsVC.delegate = self
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 60
        let collectionViewSize = collectionView.bounds.width - padding
        let width = collectionViewSize / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

extension HomeViewController: DetailsDeviceDelegate {
    
    func updateDeviceStates(device: Device) {
        if let item = devicesArray.firstIndex(where: {$0.id == device.id}) {
            let indexpath = IndexPath(item: item, section: 0)
            devicesArray[item] = device
            devicesCollectionView?.reloadItems(at: [indexpath])
        }
    }
}

enum ProductType: String {
    case light = "Light"
    case rollerShutter = "RollerShutter"
    case heater = "Heater"
}
