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
