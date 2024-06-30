//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import UIKit
import Combine
import TinyConstraints

final class DiscoverViewController: UIViewController {
    private let viewModel: DiscoverViewModel
    private var cancellables = Set<AnyCancellable>()
    var coordinator: DiscoverCoordinator?
    
    private lazy var poolTableView: UITableView = makeTableView()
    private lazy var detailButton: CustomButton = makeCustomButton()
    
    init(viewModel: DiscoverViewModel, coordinator: DiscoverCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailButton.layer.cornerRadius = detailButton.bounds.height / 3.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        setupNavigationBar()
        setupUI()
        setupBindings()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constant.mainTitle
        navigationItem.titleView?.tintColor = .black
        navigationItem.leftBarButtonItem = createProfileBarButtonItem()
        navigationItem.rightBarButtonItem = createAddButton()
    }
    
    private func createProfileBarButtonItem() -> UIBarButtonItem {
        let profileImageView = UIImageView(image: UIImage(named: "avatar"))
        configureProfileImageView(profileImageView)
        return UIBarButtonItem(customView: profileImageView)
    }
    
    private func configureProfileImageView(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = UIDimensions.tiny.value * 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: UIDimensions.large.value).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIDimensions.large.value).isActive = true
    }
    
    private func createAddButton() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        addButton.tintColor = .activeColor
        return addButton
    }
  
    private func setupBindings() {
        viewModel.$polls
            .receive(on: RunLoop.main)
            .sink { [weak self] polls in
                guard let self = self else { return }
                self.poolTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func add() {
       debugPrint("Added")
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "pollTableView"
        tableView.register(PollTableViewCell.self, forCellReuseIdentifier: "PollCell")
        return tableView
    }
    
    private func makeCustomButton() -> CustomButton {
        let button = CustomButton(
            title: "\(viewModel.polls.count) Active Polls",
            subtitle: "See Details",
            icon: UIImage(named: "arrow")
        )
        return button
    }
    
    private func setupUI() {
        view.addSubview(poolTableView)
        view.addSubview(detailButton)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            detailButton.topToSuperview(usingSafeArea: true).constant = UIDimensions.extraLarge.value
            detailButton.trailingToSuperview().constant = -UIDimensions.extraLarge.value
            detailButton.leadingToSuperview().constant = UIDimensions.extraLarge.value
            detailButton.layer.cornerRadius = detailButton.bounds.height / 2
            
            poolTableView.topToBottom(of: detailButton).constant = UIDimensions.extraLarge.value + 2
            poolTableView.edgesToSuperview(excluding: .top ,insets: .uniform(UIDimensions.small.value))
        } else {
            detailButton.topToSuperview(usingSafeArea: true).constant = UIDimensions.tiny.value
            detailButton.trailingToSuperview().constant = -UIDimensions.small.value
            detailButton.leadingToSuperview().constant = UIDimensions.small.value
            detailButton.layer.cornerRadius = detailButton.bounds.height / 2
            
            poolTableView.topToBottom(of: detailButton).constant = UIDimensions.tiny.value + 2
            poolTableView.edgesToSuperview(excluding: .top ,insets: .uniform(UIDimensions.tiny.value + 2))
        }
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.polls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PollCell", for: indexPath) as! PollTableViewCell
        let poll = viewModel.polls[indexPath.row]
        cell.poll = poll
        cell.configure(with: poll)
        return cell
    }
}

