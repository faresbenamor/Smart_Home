//
//  DetailsDeviceViewController.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 27/1/2023.
//

import UIKit
import Combine

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
    var viewModel: DetailsViewModel
    private var subscriptions = Set<AnyCancellable>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
        subscribeControlsChanges()
        fillData()
    }
    
    // MARK: - Init
    public required init(viewModel: DetailsViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func subscribeControlsChanges() {
        viewModel.$sliderTemperatureValue
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.updateTemperatureLabel()
            }.store(in: &subscriptions)
        
        viewModel.$sliderIntensityValue
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.updateIntensityLabel()
            }.store(in: &subscriptions)
        
        viewModel.$sliderPositionValue
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.updatePositionLabel()
            }.store(in: &subscriptions)
        
        viewModel.$switchLightIsOn
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.updateLightImage()
            }.store(in: &subscriptions)
        
        viewModel.$switchHeaterIsOn
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.updateHeaterImage()
            }.store(in: &subscriptions)
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
        intensityOrPositionSlider.addTarget(self, action: #selector(sliderIntensityOrPositionChange(_:)), for: .valueChanged)
        temperatureSlider.addTarget(self, action: #selector(tempSliderChange(_:)), for: .valueChanged)
        
        // Switcher Add Action
        switcher.addTarget(self, action: #selector(switcherChanged(_:)), for: .valueChanged)
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
    
    @objc func sliderIntensityOrPositionChange(_ sender: UISlider!) {
        viewModel.getProductType() == .light ? (viewModel.sliderIntensityValue = Int(sender.value)) : (viewModel.sliderPositionValue = Int(sender.value))
        
        // Update changes to passed device object
        viewModel.getProductType() == .light ? (viewModel.passedDevice.intensity = viewModel.sliderIntensityValue) : (viewModel.passedDevice.position = viewModel.sliderPositionValue)
        
        // Pass changes to delegate
        delegate?.updateDeviceStates(device: viewModel.passedDevice)
    }
    
    @objc func tempSliderChange(_ sender: UISlider!) {
        // Update slider value
        viewModel.sliderTemperatureValue = Int(sender.value)
        
        // Update changes to passed device object
        viewModel.passedDevice.temperature = viewModel.sliderTemperatureValue
        
        // Pass changes to delegate
        delegate?.updateDeviceStates(device: viewModel.passedDevice)
    }
    
    @objc func switcherChanged(_ sender: UISwitch!) {
        // Update switch value
        viewModel.getProductType() == .light ? (viewModel.switchLightIsOn = sender.isOn) : (viewModel.switchHeaterIsOn = sender.isOn)
        
        // Update changes to passed device object
        viewModel.getProductType() == .light ? (viewModel.passedDevice.mode = sender.isOn ? "ON" : "OFF") : (viewModel.passedDevice.mode = sender.isOn ? "ON" : "OFF")
        
        // Pass changes to delegate
        delegate?.updateDeviceStates(device: viewModel.passedDevice)
    }
    
    private func updateTemperatureLabel() {
        if let temperature = viewModel.sliderTemperatureValue {
            temperatureValueLabel.text = "\(temperature)\(viewModel.getLabelDegree())"
        }
    }
    
    private func updateIntensityLabel() {
        if let intensity = viewModel.sliderIntensityValue {
            intensityOrPositionValueLabel.text = "\(intensity)\(viewModel.getLabelDegree())"
        }
    }
    
    private func updatePositionLabel() {
        if let position = viewModel.sliderPositionValue {
            intensityOrPositionValueLabel.text = "\(position)\(viewModel.getLabelDegree())"
        }
    }
    
    private func updateLightImage() {
        if let isOn = viewModel.switchLightIsOn {
            imageDevice.image = isOn ? UIImage(named: ImagesNames.lightOn) : UIImage(named: ImagesNames.lightOff)
        }
    }
    
    private func updateHeaterImage() {
        if let isOn = viewModel.switchHeaterIsOn {
            imageDevice.image = isOn ? UIImage(named: ImagesNames.heaterOn) : UIImage(named: ImagesNames.heaterOff)
        }
    }
    
    func fillData() {
        nameDeviceLabel.text = viewModel.getDeviceName()
        
        switch viewModel.getProductType() {
            
        case .light:
            setLightData()
            
        case .heater:
            setHeaterData()
            
        case .rollerShutter:
            setRollerShutterData()
        }
    }
    
    func setLightData() {
        imageDevice.image = viewModel.getDeviceMode() == "ON" ? viewModel.getImageOn() : viewModel.getImageOff()
        switcher.isOn = viewModel.getDeviceMode() == "ON" ? true : false
        intensityOrPositionLabel.text = L10n.intensity
        intensityOrPositionValueLabel.text = (viewModel.sliderIntensityValue?.description ?? "") + viewModel.getLabelDegree()
        intensityOrPositionSlider.value = Float(viewModel.sliderIntensityValue ?? 0)
        temperatureStackView.isHidden = true
    }
    
    func setRollerShutterData() {
        imageDevice.image = UIImage(named: ImagesNames.rolleShutter)
        intensityOrPositionLabel.text = L10n.position
        intensityOrPositionValueLabel.text = (viewModel.sliderPositionValue?.description ?? "") + viewModel.getLabelDegree()
        intensityOrPositionSlider.value = Float(viewModel.sliderPositionValue ?? 0)
        temperatureStackView.isHidden = true
        modeStackView.isHidden = true
    }
    
    func setHeaterData() {
        imageDevice.image = viewModel.getDeviceMode() == "ON" ? viewModel.getImageOn() : viewModel.getImageOff()
        switcher.isOn = viewModel.getDeviceMode() == "ON" ? true : false
        temperatureValueLabel.text = (viewModel.sliderTemperatureValue?.description ?? "") + viewModel.getLabelDegree()
        temperatureSlider.value = Float(viewModel.sliderTemperatureValue ?? 0)
        intensityOrPositionStackView.isHidden = true
        
        // Vertical Slider
        temperatureSlider.transform = CGAffineTransform(rotationAngle: -.pi/2)
        temperatureSlider.heightAnchor.constraint(equalToConstant: temperatureSlider.frame.height + 40).isActive = true
        widthSliderTemp.isActive = false
        temperatureSlider.widthAnchor.constraint(equalTo: temperatureStackView.widthAnchor, multiplier: 0.4).isActive = true
    }
}

protocol DetailsDeviceDelegate: AnyObject {
    func updateDeviceStates(device: Device)
}
