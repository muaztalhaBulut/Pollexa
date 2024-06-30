//
//  PoolTableViewCell.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import UIKit
import Combine

final class PollTableViewCell: UITableViewCell {
    @Published var poll: Poll? {
        didSet {
            if let poll = poll {
                configure(with: poll)
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIDimensions.small.value
        view.backgroundColor = .cellColor
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var optionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.register(PollOptionCollectionViewCell.self, forCellWithReuseIdentifier: "OptionCell")
        return collectionView
    }()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = UIDimensions.tiny.value * 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.current.userInterfaceIdiom == .pad ?  UIFont.systemFont(ofSize: 20, weight: .regular) : UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.current.userInterfaceIdiom == .pad ?  .systemFont(ofSize: 17) : .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .seperatorColor
        return view
    }()
    
    private lazy var lastVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.current.userInterfaceIdiom == .pad ? .systemFont(ofSize: 15) : .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.current.userInterfaceIdiom == .pad ?  UIFont.systemFont(ofSize: 22, weight: .bold) : UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var totalVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.current.userInterfaceIdiom == .pad ? .systemFont(ofSize: 17) : .systemFont(ofSize: 14)
        label.textColor = .gray
        label.accessibilityIdentifier = "Total Votes"
        return label
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userImage, userNameLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.spacing = UIDevice.current.userInterfaceIdiom == .pad ? UIDimensions.small.value : UIDimensions.tiny.value
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userStackView, seperator, lastVoteLabel, questionLabel])
        stackView.axis = .vertical
        stackView.spacing = UIDevice.current.userInterfaceIdiom == .pad ? UIDimensions.small.value : UIDimensions.tiny.value
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [optionsCollectionView, totalVoteLabel])
        stackView.axis = .vertical
        stackView.spacing = UIDevice.current.userInterfaceIdiom == .pad ? UIDimensions.small.value : UIDimensions.tiny.value
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.accessibilityIdentifier = "PollTableViewCell"
        userImage.accessibilityIdentifier = "userImageView"
        userNameLabel.accessibilityIdentifier = "userNameLabel"
        timeLabel.accessibilityIdentifier = "timeLabel"
        questionLabel.accessibilityIdentifier = "questionLabel"
        totalVoteLabel.accessibilityIdentifier = "totalVoteLabel"
        optionsCollectionView.accessibilityIdentifier = "optionsCollectionView"
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setupUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(userStackView)
        containerView.addSubview(headerStackView)
        containerView.addSubview(footerStackView)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            containerView.edgesToSuperview(insets: .uniform(UIDimensions.large.value))
            
            userImage.height(UIDimensions.extraLarge.value)
            userImage.width(UIDimensions.extraLarge.value)
            
            userStackView.topToSuperview().constant = UIDimensions.large.value
            userStackView.trailingToSuperview().constant = -UIDimensions.extraLarge.value
            userStackView.leadingToSuperview().constant = UIDimensions.extraLarge.value
            
            headerStackView.topToBottom(of: userStackView).constant = UIDimensions.large.value + 2
            headerStackView.trailingToSuperview().constant = -UIDimensions.extraLarge.value
            headerStackView.leadingToSuperview().constant = UIDimensions.extraLarge.value
            
            optionsCollectionView.height(200)
            seperator.height(1.0)
            
            footerStackView.topToBottom(of: headerStackView).constant = UIDimensions.extraLarge.value
            footerStackView.leadingToSuperview().constant = UIDimensions.extraLarge.value
            footerStackView.trailingToSuperview().constant = -UIDimensions.extraLarge.value
            footerStackView.bottomToSuperview().constant = -UIDimensions.extraLarge.value
            
        } else {
            containerView.edgesToSuperview(insets: .uniform(UIDimensions.tiny.value + 2))
            
            userImage.height(UIDimensions.large.value)
            userImage.width(UIDimensions.large.value)
            
            userStackView.topToSuperview().constant = UIDimensions.tiny.value + 2
            userStackView.trailingToSuperview().constant = -UIDimensions.small.value
            userStackView.leadingToSuperview().constant = UIDimensions.small.value
            
            headerStackView.topToBottom(of: userStackView).constant = UIDimensions.tiny.value + 2
            headerStackView.trailingToSuperview().constant = -UIDimensions.small.value
            headerStackView.leadingToSuperview().constant = UIDimensions.small.value
            
            
            optionsCollectionView.height(130)
            seperator.height(0.5)
            
            footerStackView.topToBottom(of: headerStackView).constant = UIDimensions.small.value
            footerStackView.leadingToSuperview().constant = UIDimensions.small.value
            footerStackView.trailingToSuperview().constant = -UIDimensions.small.value
            footerStackView.bottomToSuperview().constant = -UIDimensions.small.value
        }
    }
    
    func configure(with poll: Poll) {
        userImage.image = poll.user.profileImage
        userNameLabel.text = poll.user.name
        timeLabel.text = poll.initTime
        lastVoteLabel.text = "Last Voted \(poll.lastVoted)".uppercased()
        questionLabel.text = poll.question
        totalVoteLabel.text = "\(poll.totalVotes) Total Votes"
        optionsCollectionView.reloadData()
    }
}

extension PollTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poll?.options.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCell", for: indexPath) as! PollOptionCollectionViewCell
        if let poll = poll {
            cell.configure(with: poll.options[indexPath.item], poll: poll , totalVotes: poll.totalVotes)
        }
        let isRightCell = indexPath.row % 2 == 0
        cell.isRightCell = isRightCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var poll = poll else { return }
        
        poll.totalVotes += 1
        poll.options[indexPath.item].votes += 1
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        poll.lastVoted = timeAgoSinceDate(currentDate, caseStyle: .uppercase)
        
        poll.options[indexPath.item].selectedVote = true
        poll.didVote = true
        self.poll = poll
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let width = (collectionView.frame.width - 20) / 2
            return CGSize(width: width, height: collectionView.frame.height)
        } else {
            let width = (collectionView.frame.width - 10) / 2
            return CGSize(width: width, height: collectionView.frame.height)
        }
    }
}
