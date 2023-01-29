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
        
        let model = devicesArray[indexPath.item]
        
        cell.configure(with: CellViewModel(intensity: model.intensity, mode: model.mode, position: model.position, temperature: model.temperature, productType: model.productType))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(devicesArray[indexPath.item])
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
            devicesCollectionView.reloadItems(at: [indexpath])
        }
    }
}

enum ProductType: String {
    case light = "Light"
    case rollerShutter = "RollerShutter"
    case heater = "Heater"
}
