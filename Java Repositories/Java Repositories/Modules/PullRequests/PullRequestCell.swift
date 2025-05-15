//
//  PullRequestCell.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 13/05/25.
//

import Foundation
import UIKit

protocol PullRequestCellProtocol {
    func addInfo(_ info: PullRequestModel)
}

class PullRequestCell: UITableViewCell {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let footerStack = UIStackView()
    private let mainStack = UIStackView()
    
    static var identifier = "PullRequestCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        configureAccessibility()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 2

        bodyLabel.font = UIFont.systemFont(ofSize: 14)
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.numberOfLines = 2

        authorLabel.font = UIFont.systemFont(ofSize: 13)
        authorLabel.textColor = .tertiaryLabel

        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .tertiaryLabel
        dateLabel.textAlignment = .right

        footerStack.axis = .horizontal
        footerStack.distribution = .equalSpacing
        footerStack.addArrangedSubview(authorLabel)
        footerStack.addArrangedSubview(dateLabel)

        mainStack.axis = .vertical
        mainStack.spacing = 4
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(bodyLabel)
        mainStack.addArrangedSubview(footerStack)

        contentView.addSubview(mainStack)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func formatDate(_ isoString: String?) -> String? {
        guard let isoString = isoString else { return nil }
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoString) else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    private func configureAccessibility() {
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityTraits = .header

        dateLabel.isAccessibilityElement = true

        authorLabel.isAccessibilityElement = true

        bodyLabel.isAccessibilityElement = true
        bodyLabel.accessibilityTraits = .staticText
    }
}

extension PullRequestCell: PullRequestCellProtocol {
    
    func addInfo(_ info: PullRequestModel) {
        titleLabel.text = info.prTitle
        bodyLabel.text = info.prBody
        authorLabel.text = info.user.prOwnerName
        dateLabel.text = formatDate(info.prDate)
        
        titleLabel.accessibilityLabel = "Título do pr: \(info.prTitle ?? "")"
        bodyLabel.accessibilityLabel = "Descrição do pr: \(info.prBody ?? "")"
        authorLabel.accessibilityLabel = "Autor do pr: \(info.user.prOwnerName)"
        dateLabel.accessibilityLabel = "Data do pr: \(info.prDate ?? "")"
    }
    
    
}

