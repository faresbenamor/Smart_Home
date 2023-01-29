//
//  DevicesCollectionViewCell.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 25/1/2023.
//

import UIKit

class DevicesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var imageDevice: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var modeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var positionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var intensityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageDevice)
        stackView.addArrangedSubview(modeLabel)
        stackView.addArrangedSubview(positionLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(intensityLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            imageDevice.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    public func configure(with viewModel: CellViewModel) {
        let product = ProductType(rawValue: viewModel.productType)

        if let mode = viewModel.mode {
            modeLabel.text = "\(L10n.mode): \(mode)"
            modeLabel.isHidden = false
        }
        else {
            modeLabel.isHidden = true
        }
        
        // Intensity for Light
        if let intensity = viewModel.intensity {
            intensityLabel.text = "\(L10n.intensity): \(intensity.description)%"
            intensityLabel.isHidden = false
        }
        else {
            intensityLabel.isHidden = true
        }
        
        // Position for RullerShutter
        if let position = viewModel.position {
            if position == 0 {
                positionLabel.text = L10n.closed
            }
            else if position == 100 {
                positionLabel.text = L10n.opened
            }
            else {
                positionLabel.text = "\(L10n.openedAt) \(position.description)%"
            }
            positionLabel.isHidden = false
        }
        else {
            positionLabel.isHidden = true
        }
        
        // Temperature for Heater
        if let temperature = viewModel.temperature {
            
            temperatureLabel.text = "Temp: \(temperature.description)°"
            temperatureLabel.isHidden = false
        }
        else {
            temperatureLabel.isHidden = true
        }

        // Image Device
        switch product {

        case .rollerShutter:
            imageDevice.image = UIImage(named: ImagesNames.rolleShutter)

        case .heater:
            imageDevice.image = viewModel.mode == "ON" ? UIImage(named: ImagesNames.heaterOn) : UIImage(named: ImagesNames.heaterOff)

        case .light:
            imageDevice.image = viewModel.mode == "ON" ? UIImage(named: ImagesNames.lightOn) : UIImage(named: ImagesNames.lightOff)

        default:
            break
        }
    }
    
    // A little animation
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
              UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
                })
            }
            else {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                })
            }
        }
    }
}
