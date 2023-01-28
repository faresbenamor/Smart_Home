//
//  ViewController.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 25/1/2023.
//

import UIKit

class HomeViewController: UIViewController {

    var devicesCollectionView: UICollectionView?
    public var viewModel: HomeViewModel
    var devicesArray: [Device] = []
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    public required init(viewModel: HomeViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActivityIndicator()
        setupNavBar()
        getDevices()
    }
    
    func setupActivityIndicator() {
        devicesCollectionView?.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.color = .white
    }
    
    func setupCollectionView() {
        // FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        devicesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let devicesCollectionView = devicesCollectionView else { return }
        
        // DataSource and Delegate
        devicesCollectionView.delegate = self
        devicesCollectionView.dataSource = self
        
        // Register and addSubView
        devicesCollectionView.register(DevicesCollectionViewCell.self, forCellWithReuseIdentifier: DevicesCollectionViewCell.identifier)
        view.addSubview(devicesCollectionView)
        
        // BackgroundColor
        view.backgroundColor = .customBlue
        devicesCollectionView.backgroundColor = .customBlue
        
        // AutoLayout
        devicesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            devicesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            devicesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            devicesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            devicesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = L10n.smartHouse
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
    }
    
    func getDevices() {
        activityIndicator.startAnimating()
        viewModel.getDevices({ [weak self] iSsuccess, devicesResponse in
            if iSsuccess {
                guard let devicesResponse = devicesResponse else { return }
                self?.devicesArray = devicesResponse.devices
                DispatchQueue.main.async {
                    self?.devicesCollectionView?.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
            else {
                DispatchQueue.main.async {
                    self?.showAlert(title: L10n.error, message: L10n.errorAlertMessage)
                }
            }
        })
    }
}
