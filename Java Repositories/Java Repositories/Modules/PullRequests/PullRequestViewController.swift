//
//  PullRequestViewController.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 11/05/25.
//

import Foundation
import UIKit
import Combine

class PullRequestViewController: UIViewController {
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PullRequestCell.self, forCellReuseIdentifier: PullRequestCell.identifier)
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return table
    }()
    
    private let cellHeight: CGFloat = 120
    private let viewModel: PullRequestBusinessLogic
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: PullRequestBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
        bindViewModel()
        viewModel.fetchPullRequests()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        title = viewModel.repoName
        setUpTableView()
    }
    
    
    private func bindViewModel() {
        viewModel.pullRequestsListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] a in
                self?.tableview.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setUpTableView() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: 8.0),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -8.0)
        ])
    }
}

extension PullRequestViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pullRequestsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.identifier) as? PullRequestCellProtocol
        let pr = viewModel.pr(at: indexPath.row)
        cell?.addInfo(pr)
        return cell as? UITableViewCell ?? UITableViewCell()
    }
    
}
