//
//  ViewController.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 25/1/2023.
//

import UIKit

class HomeViewController: UIViewController {

    public var viewModel: HomeViewModel
    var callback: ((_ item: Device) -> Void)?
    var devicesArray: [Device] = [] {
        didSet {
            devicesCollectionView.reloadData()
        }
    }
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var devicesCollectionView: UICollectionView = {
        // FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .customBlue
        collectionView.register(DevicesCollectionViewCell.self, forCellWithReuseIdentifier: DevicesCollectionViewCell.identifier)
        
        // DataSource and Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
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
        setupUI()
        setupNavBar()
        getDevices()
    }
    
    func setupUI() {
        // View
        view.backgroundColor = .customBlue
        view.addSubview(devicesCollectionView)
        
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
        showActivityIndicator(activityIndicator: activityIndicator, onView: devicesCollectionView)
        viewModel.getDevices({ [weak self] iSsuccess, homeResponse in
            guard let `self` = self else { return }
            if iSsuccess {
                guard let homeResponse = homeResponse else { return }
                DispatchQueue.main.async {
                    self.devicesArray = homeResponse.devices
                    self.stopActivityIndicator(activityIndicator: self.activityIndicator)
                }
            }
            else {
                DispatchQueue.main.async {
                    self.showAlert(title: L10n.error, message: L10n.errorAlertMessage)
                }
            }
        })
    }
}
