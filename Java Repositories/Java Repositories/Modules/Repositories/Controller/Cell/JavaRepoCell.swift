//
//  JavaRepoCell.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation
import UIKit

protocol JavaRepoCellProtocol {
    func addInfo(_ info: JavaProjectsModel)
}


class JavaRepoCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpLayout()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    static let identifier = "JavaRepoCell"
    
    lazy var labelRepoName: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var labelRepoDesc: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var labelStarsCount: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var labelForkCount: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var labelLogin: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var imgAvatar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var labelRepoOwner: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpLayout(){
        setupViewContainer()
        setupLabelRepoName()
        setupLabelRepoDesc()
        setupLabelForkCount()
        setupLabelStarsCount()
        setupImgAvatar()
        setupLabelRepoOwner()
    }
    
    func setupViewContainer() {
        self.contentView.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 20),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -20),
            viewContainer.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                               constant: 8),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -8)
        ])
    }
    
    func setupLabelRepoName() {
        self.viewContainer.addSubview(labelRepoName)
        NSLayoutConstraint.activate([
            labelRepoName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 10),
            labelRepoName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -10),
            labelRepoName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                               constant: 10),
        ])
    }
    
    func setupLabelRepoDesc() {
        self.viewContainer.addSubview(labelRepoDesc)
        NSLayoutConstraint.activate([
            labelRepoDesc.leadingAnchor.constraint(equalTo: labelRepoName.leadingAnchor),
            labelRepoDesc.topAnchor.constraint(equalTo: labelRepoName.bottomAnchor, constant: 2),
            labelRepoDesc.widthAnchor.constraint(equalToConstant: 200),
            labelRepoDesc.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupLabelForkCount() {
        self.viewContainer.addSubview(labelForkCount)
        NSLayoutConstraint.activate([
            labelForkCount.leadingAnchor.constraint(equalTo: labelRepoDesc.leadingAnchor),
            labelForkCount.topAnchor.constraint(equalTo: labelRepoDesc.bottomAnchor, constant: 2)
        ])
    }
    
    func setupLabelStarsCount() {
        self.viewContainer.addSubview(labelStarsCount)
        NSLayoutConstraint.activate([
            labelStarsCount.leadingAnchor.constraint(equalTo: labelForkCount.trailingAnchor, constant: 10),
            labelStarsCount.topAnchor.constraint(equalTo: labelForkCount.topAnchor)
        ])
    }
    
    func setupImgAvatar() {
        self.viewContainer.addSubview(imgAvatar)
        NSLayoutConstraint.activate([
            imgAvatar.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20),
            imgAvatar.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            imgAvatar.heightAnchor.constraint(equalToConstant: 30),
            imgAvatar.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func setupLabelRepoOwner() {
        self.viewContainer.addSubview(labelRepoOwner)
        NSLayoutConstraint.activate([
            labelRepoOwner.centerXAnchor.constraint(equalTo: imgAvatar.centerXAnchor),
            labelRepoOwner.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 10),
        ])
    }
    
}

extension JavaRepoCell: JavaRepoCellProtocol {
    
    func addInfo(_ info: JavaProjectsModel) {
        labelRepoName.text = info.repositoryName
        labelRepoDesc.text = info.repositoryDescripton
        labelForkCount.text = "🍴\(info.forksCount)"
        labelStarsCount.text = "⭐️\(info.starsCount)"
        labelRepoOwner.text = info.owner.login
    }
    
    
}
