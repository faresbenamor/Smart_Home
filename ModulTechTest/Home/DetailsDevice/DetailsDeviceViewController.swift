//
//  DetailsDeviceViewController.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import UIKit

class DetailsDeviceViewController: UIViewController {

    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var modeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var modeLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.mode
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .orange
        return switcher
    }()
    
    var intensityOrPositionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var intensityOrPositionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var intensityOrPositionValueLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var intensityOrPositionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .orange
        slider.maximumValue = 100
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var temperatureStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.temperature
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var temperatureValueLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var temperatureSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .orange
        slider.minimumValue = 7
        slider.maximumValue = 28
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var nameDeviceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var imageDevice: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var passedDevice: Device?
    var widthSliderTemp: NSLayoutConstraint!
    weak var delegate: DetailsDeviceDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
        fillData()
    }
    
    func setupUI() {
        // View
        view.backgroundColor = .customBlue
        view.addSubview(contentView)
        
        // contentStackView
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameDeviceLabel)
        contentStackView.addArrangedSubview(lineView)
        contentStackView.addArrangedSubview(imageDevice)
        contentStackView.addArrangedSubview(modeStackView)
        contentStackView.addArrangedSubview(intensityOrPositionStackView)
        contentStackView.addArrangedSubview(temperatureStackView)
        
        // ModeStackview
        modeStackView.addArrangedSubview(modeLabel)
        modeStackView.addArrangedSubview(switcher)
        
        // Intensity Or Position StackView
        intensityOrPositionStackView.addArrangedSubview(intensityOrPositionLabel)
        intensityOrPositionStackView.addArrangedSubview(intensityOrPositionValueLabel)
        intensityOrPositionStackView.addArrangedSubview(intensityOrPositionSlider)
        
        // Temperature StackView
        temperatureStackView.addArrangedSubview(temperatureLabel)
        temperatureStackView.addArrangedSubview(temperatureValueLabel)
        temperatureStackView.addArrangedSubview(temperatureSlider)
        
        // Slider Add Action
        intensityOrPositionSlider.addTarget(self, action: #selector(sliderIntensityOrPositionChange), for: .valueChanged)
        temperatureSlider.addTarget(self, action: #selector(tempSliderChange), for: .valueChanged)
        
        // Switcher Add Action
        switcher.addTarget(self, action: #selector(switcherChanged), for: .valueChanged)
    }
    
    func setupAutoLayout() {
        widthSliderTemp = temperatureSlider.widthAnchor.constraint(equalTo: temperatureStackView.widthAnchor, multiplier: 0.5)
        
        NSLayoutConstraint.activate([
            // ContentView
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            // contentStackView
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // LineView
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            // UIImageView
            imageDevice.heightAnchor.constraint(equalToConstant: 120),
            
            // Slider
            intensityOrPositionSlider.widthAnchor.constraint(equalTo: intensityOrPositionStackView.widthAnchor, multiplier: 0.5),
            widthSliderTemp
        ])
    }
    
    @objc func sliderIntensityOrPositionChange() {
        // Update label value
        intensityOrPositionValueLabel.text = Int(intensityOrPositionSlider.value).description + "%"
        
        // Update changes to passed device object
        guard let productType = passedDevice?.productType else { return }
        let product = ProductType(rawValue: productType)
        product == .light ? (passedDevice?.intensity = Int(intensityOrPositionSlider.value)) : (passedDevice?.position = Int(intensityOrPositionSlider.value))
        
        // Pass changes to delegate
        guard let passedDevice = passedDevice else { return }
        delegate?.updateDeviceStates(device: passedDevice)
    }
    
    @objc func tempSliderChange() {
        // Update label value
        temperatureValueLabel.text = Int(temperatureSlider.value).description + "°"
        
        // Update changes to passed device object
        passedDevice?.temperature = Int(temperatureSlider.value)
        
        // Pass changes to delegate
        guard let passedDevice = passedDevice else { return }
        delegate?.updateDeviceStates(device: passedDevice)
    }
    
    @objc func switcherChanged() {
        guard let productType = passedDevice?.productType else { return }
        let product = ProductType(rawValue: productType)
        
        if product == .light {
            imageDevice.image = switcher.isOn ? UIImage(named: "DeviceLightOnIcon") : UIImage(named: "DeviceLightOffIcon")
            
            // Update changes to passed device object
            passedDevice?.mode = switcher.isOn ? "ON" : "OFF"
            
            // Pass changes to delegate
            guard let passedDevice = passedDevice else { return }
            delegate?.updateDeviceStates(device: passedDevice)
            
        }
        else if product == .heater {
            imageDevice.image = switcher.isOn ? UIImage(named: "DeviceHeaterOnIcon") : UIImage(named: "DeviceHeaterOffIcon")
            
            // Update changes to passed device object
            passedDevice?.mode = switcher.isOn ? "ON" : "OFF"
            
            // Pass changes to delegate
            guard let passedDevice = passedDevice else { return }
            delegate?.updateDeviceStates(device: passedDevice)
        }
    }
    
    func fillData() {
        guard let productType = passedDevice?.productType else { return }
        let product = ProductType(rawValue: productType)
        
        switch product {
            
        case .light:
            setLightData()
            
        case .rollerShutter:
            setRollerShutterData()
            
        case .heater:
            setHeaterData()
            
        default:
            break
        }
    }
    
    func setLightData() {
        nameDeviceLabel.text = L10n.light
        imageDevice.image = passedDevice?.mode == "ON" ? UIImage(named: "DeviceLightOnIcon") : UIImage(named: "DeviceLightOffIcon")
        switcher.isOn = passedDevice?.mode == "ON" ? true : false
        intensityOrPositionLabel.text = L10n.intensity
        intensityOrPositionValueLabel.text = "\(passedDevice?.intensity?.description ?? "")%"
        if let intensity = passedDevice?.intensity {
            intensityOrPositionSlider.value = Float(intensity)
        }
        temperatureStackView.isHidden = true
    }
    
    func setRollerShutterData() {
        nameDeviceLabel.text = L10n.rollerShutter
        imageDevice.image = UIImage(named: "DeviceRollerShutterIcon")
        intensityOrPositionLabel.text = L10n.position
        intensityOrPositionValueLabel.text = "\(passedDevice?.position?.description ?? "")%"
        if let position = passedDevice?.position {
            intensityOrPositionSlider.value = Float(position)
        }
        temperatureStackView.isHidden = true
        modeStackView.isHidden = true
    }
    
    func setHeaterData() {
        nameDeviceLabel.text = L10n.heater
        imageDevice.image = passedDevice?.mode == "ON" ? UIImage(named: "DeviceHeaterOnIcon") : UIImage(named: "DeviceHeaterOffIcon")
        switcher.isOn = passedDevice?.mode == "ON" ? true : false
        temperatureValueLabel.text = (passedDevice?.temperature?.description ?? "") + "°"
        if let temp = passedDevice?.temperature {
            temperatureSlider.value = Float(temp)
        }
        temperatureSlider.transform = CGAffineTransform(rotationAngle: -.pi/2)
        temperatureSlider.heightAnchor.constraint(equalToConstant: temperatureSlider.frame.height + 40).isActive = true
        widthSliderTemp.isActive = false
        temperatureSlider.widthAnchor.constraint(equalTo: temperatureStackView.widthAnchor, multiplier: 0.4).isActive = true
        intensityOrPositionStackView.isHidden = true
    }
}

protocol DetailsDeviceDelegate: AnyObject {
    func updateDeviceStates(device: Device)
}
