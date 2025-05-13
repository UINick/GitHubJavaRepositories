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
        table.separatorStyle = .none
        
        return table
    }()
    
    private let cellHeight: CGFloat = 80
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
        view.backgroundColor = .white
        setUpTableView()
        bindViewModel()
        viewModel.fetchPullRequests()
    }
    
    
    private func bindViewModel() {
        viewModel.pullRequestsListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] a in
                a.count
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
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

        let repo = viewModel.pr(at: indexPath.row)
        cell.textLabel?.text = repo.prTitle ?? ""
        cell.detailTextLabel?.text = repo.prBody ?? ""

        return cell
    }
    
}
